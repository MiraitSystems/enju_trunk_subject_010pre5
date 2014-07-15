#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
class Classification < ActiveRecord::Base
  attr_accessible :parent_id, :category, :note, :classification_type_id
  has_many :subject_has_classifications, :dependent => :destroy
  has_many :subjects, :through => :subject_has_classifications
  belongs_to :classification_type, :validate => true
  #has_many_polymorphs :subjects, :from => [:concepts, :places], :through => :subject_has_classifications

  validates_associated :classification_type
  validates_presence_of :category, :classification_type
  validates_uniqueness_of :category, :scope => :classification_type_id
  searchable do
    text :category, :note, :subject
    integer :subject_ids, :multiple => true
    integer :classification_type_id
  end
  #acts_as_nested_set
  #acts_as_taggable_on :tags
  normalize_attributes :category

  paginates_per 10

  private
  def subject
    subjects.collect{|s| [s.term, s.term_transcription]}
  end
end

# == Schema Information
#
# Table name: classifications
#
#  id                     :integer          not null, primary key
#  parent_id              :integer
#  category               :string(255)      not null
#  note                   :text
#  classification_type_id :integer          not null
#  created_at             :datetime
#  updated_at             :datetime
#  lft                    :integer
#  rgt                    :integer
#

