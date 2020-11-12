#require 'nokogiri'

class OverviewController < ApplicationController
  def index
    files = Dir.glob("#{Rails.root}/manifests/*")
    @apps = Array.new

    App.delete_all

    files.each do |file|
      #puts "trying file " + file

      inputFile = File.read(file)
      doc = Nokogiri::XML(inputFile)
      slop = doc.slop!
      #puts "file:" + file + ", package:" + doc.manifest["package"]

      @apps << [file, slop.manifest["package"], doc.xpath("//application").size, doc.xpath("//activity").size, doc.xpath("//overlay").size,
      doc.xpath("//service").size, doc.xpath("//receiver").size, doc.xpath("//provider").size, doc.xpath("//uses-permission/@android:name").size, doc.xpath("//permission").size,
      doc.xpath("//uses-permission[@android:name='android.permission.RECEIVE_BOOT_COMPLETED']").size, doc.xpath("//application[@android:persistent='true']").size]

      #@test.at_xpath("//text/@style").value

      #doc.xpath("//service").size, doc.xpath("//receiver").size, slop.manifest.uses-permision("[@android:name='android.permission.RECEIVE_BOOT_COMPLETED']") ]


      #inputFile.close
      App.new("filename": "haha")


    end
    #file = File.read("manifests/dialer.xml")
    #doc = Nokogiri::XML(file).slop!

    #@characters = doc.xpath("manifest")
    #@characters = doc.manifest["package"]
    #@files = files

  end
end
