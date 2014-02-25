# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: items
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
