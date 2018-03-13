defmodule Doujind do
  @root_url "https://nhentai.net"

  def main do
    response = HTTPotion.get(@root_url)
    links = Floki.attribute(response.body, ".cover", "href")

    Enum.each links, &download_chapter/1
  end

  def download_chapter(link) do
    full_link = Enum.join([@root_url, link], "")
    page = HTTPotion.get(full_link)
    links = Floki.attribute(page.body, ".gallerythumb", "href")
    folder_path = String.trim(link, "/")
    File.mkdir_p(folder_path)

    Enum.each links, fn page_link ->
      download_page(folder_path, page_link)
    end
  end

  def download_page(folder, link) do
    full_link = Enum.join([@root_url, link], "")
    page = HTTPotion.get(full_link)
    links = Floki.attribute(page.body, "#image-container a img", "src")
    Enum.each links, fn image_link ->
      Download.from(image_link, folder: folder)
    end
  end
end
