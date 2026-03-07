require "test_helper"

class FolderTest < ActiveSupport::TestCase

  test "builds path" do
    root = "0"

    leaf_subfolder = 5.times.reduce(Folder.create!(name: root)) do |folder, i|
      subfolder = Folder.create!(name: i + 1, parent_folder: folder)

      expected = (i + 1).times.reduce(root) { |path, folder_i| "#{path}/#{folder_i + 1}" }

      assert_equal expected, subfolder.path

      subfolder
    end

    assert_equal "0/1/2/3/4/5", leaf_subfolder.path
  end

  test "path is folder name if root" do
    folder = Folder.create!(name: "root")

    assert "root", folder.path
  end
end
