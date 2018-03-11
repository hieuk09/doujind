defmodule Doujind do
  @root_url "https://nhentai.net"

  def main(args \\ []) do
    response = HTTPotion.get(@root_url)
    links = Floki.attribute(response.body, ".cover", "href")

    Enum.each links, &download_chapter/1
  end

  def download_chapter(link) do
    full_link = Enum.join([@root_url, link], "")
    page = HTTPotion.get(full_link)
    links = Floki.attribute(page.body, ".gallerythumb", "href")

    Enum.each links, &download_page/1
  end

  def download_page(link) do
    full_link = Enum.join([@root_url, link], "")
    page = HTTPotion.get(full_link)
    links = Floki.attribute(page.body, "#image-container a img", "src")
    Enum.each links, fn image_link ->
      Download.from(image_link)
    end
  end
end
