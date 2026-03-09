module FoldersHelper

  def folder_path_link(folder)
    links = folder.path.split("/")

    separator = "<span class='text-muted'> / </span>"
    first_link = "#{link_to(links[0], folder_by_name_path(links[0]))}#{separator} "

    path_links = links[1..-2].reduce(first_link) do |path, link|
      "#{path}#{link_to(link, folder_by_name_path(link))}#{separator}"
    end

    path_links += "<span class='text-muted'>#{links[-1]}</span>"

    path_links.html_safe
  end
end
