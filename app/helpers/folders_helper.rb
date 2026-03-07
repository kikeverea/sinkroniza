module FoldersHelper

  def folder_path_link(folder)
    links = folder.path.split("/")

    first_link = "#{link_to(links[0], folder_by_name_path(links[0]))} / "

    path_links = links[1...-1].reduce(first_link) do |path, link|
      "#{path}#{link_to(link, folder_by_name_path(link))} / "
    end


    path_links.html_safe[0...-3]
  end
end
