class AppsController < ApplicationController
  def index
    files = Dir.glob("#{Rails.root}/manifests/*")
    @apps = Array.new
    App.delete_all

    files.each do |file|
      inputFile = File.read(file)
      doc = Nokogiri::XML(inputFile)
      slop = doc.slop!

      filename = file
      package = slop.manifest["package"]
      isApp = doc.xpath("//application").size
      hasActivity = doc.xpath("//activity").size,
      hasOverlay = doc.xpath("//overlay").size
      numServices = doc.xpath("//service").size
      numReceivers = doc.xpath("//receiver").size
      numProviders = doc.xpath("//provider").size
      usedPermissions = doc.xpath("//uses-permission/@android:name").size
      createdPermissions = doc.xpath("//permission").size
      bootCompleted = doc.xpath("//uses-permission[@android:name='android.permission.RECEIVE_BOOT_COMPLETED']").size
      persistent = doc.xpath("//application[@android:persistent='true']").size

      App.new("filename": filename, "package": package, "hasActivity": hasActivity, "hasRO": hasOverlay,
        "numOfReceviers": numReceivers, "numOfServices": numServices, "numOfProviders": numProviders,
        "createdPermissions": createdPermissions, "usedPermissions": usedPermissions,
        "bootCompleted": bootCompleted, "persistent": persistent, "hasApplication": isApp).save
    end

    @apps = App.all
  end

  def read
  end
end
