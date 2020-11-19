class AppsController < ApplicationController
  helper_method :numServices
  helper_method :numReceivers
  helper_method :numProviders
  helper_method :getSupplier

  def clean
    App.delete_all
  end

  def update
    files = Dir.glob("#{Rails.root}/manifests/hcp3/**/AndroidManifest.xml")
    @apps = Array.new
    puts files

    files.each do |file|
      inputFile = File.read(file)
      doc = Nokogiri::XML(inputFile)
      slop = doc.slop!

      basepath = file.split("/apps/")[1].split("/")
      if basepath[1].include? "app"
        deployment = basepath[0] + "/" + basepath[1]
      elsif basepath[2].include? "app"
        deployment = basepath[0] + "/" + basepath[1]+ "/" + basepath[2]
      else
        deployment = basepath[0] + "/" + basepath[1]+ "/" + basepath[2]
      end

      filename = file.split("/apps/")[1]
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
      supplier = "AOSP"
      usedPermissionsList = ""
      createdPermissionsList = ""
      servicesList = ""
      receiversList = ""
      provdersList = ""

      #skip overlay apks
      next if hasOverlay > 0

      doc.xpath("//uses-permission/@android:name").each do |node|
        usedPermissionsList += node.to_s + "
        "
      end

      doc.xpath("//permission/@android:name").each do |node|
        createdPermissionsList += node.to_s + "
        "
      end

      doc.xpath("//service/@android:name").each do |node|
        servicesList += node.to_s + "
        "
      end

      doc.xpath("//receiver/@android:name").each do |node|
        receiversList += node.to_s + "
        "
      end

      doc.xpath("//provider/@android:name").each do |node|
        provdersList += node.to_s + "
        "
      end

      App.new("project": "hcp3","filename": filename, "package": package, "hasActivity": hasActivity, "hasRO": hasOverlay,
        "numOfReceivers": numReceivers, "numOfServices": numServices, "numOfProviders": numProviders,
        "createdPermissions": createdPermissions, "usedPermissions": usedPermissions,
        "bootCompleted": bootCompleted, "persistent": persistent, "hasApplication": isApp, "supplier": supplier,
        "usedPermissionsList": usedPermissionsList, "createdPermissionsList": createdPermissionsList,
        "servicesList": servicesList, "receiversList": receiversList, "provdersList": provdersList, "deployment": deployment).save
  end
end

def index
  @apps = @apps = App.where(project: "hcp3")
end

  def numServices(apps)
    numServices = 0
    apps.each do |app|
      numServices += app.servicesList.lines.count
      puts "app=" + app.package + ", has services:" + app.servicesList.size.to_s
    end
    puts "Found services:" + numServices.to_s
    @numServices = numServices
  end

  def numReceivers(apps)
    numReceivers = 0
    apps.each do |app|
      numReceivers += app.receiversList.lines.count
    end
    @numReceivers = numReceivers
  end

  def numProviders(apps)
    numProviders = 0
    apps.each do |app|
      numProviders += app.provdersList.lines.count
    end
    @numProviders = numProviders
  end

  def getSupplier(packageName)
    if packageName.downcase.include? "eso"
      @getSupplier = "eso"
    elsif packageName.downcase.include? "cerence"
      @getSupplier = "eso"
    elsif packageName.downcase.include? "vwgroup"
      @getSupplier = "eso"
    elsif packageName.downcase.include? "harman"
      @getSupplier = "HAD"
    else
      @getSupplier = "AOSP"
    end
  end


end
