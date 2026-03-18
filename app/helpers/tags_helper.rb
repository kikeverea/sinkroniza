module TagsHelper

  def tag_badge(tag)
    badge(tag.name, tag.color, classes: "fs-9", color_as_style: true)
  end
end
