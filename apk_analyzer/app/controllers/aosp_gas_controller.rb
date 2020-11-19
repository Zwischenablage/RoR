class AospGasController < ApplicationController
  helper_method :numServices
  helper_method :numReceivers
  helper_method :numProviders

  def update
    files = Dir.glob("#{Rails.root}/manifests/AOSP_GAS/*")
    @apps = Array.new

    files.each do |file|
      inputFile = File.read(file)
      doc = Nokogiri::XML(inputFile)
      slop = doc.slop!

      filename = File.basename(file)
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

      App.new("project": "aosp", "filename": filename, "package": package, "hasActivity": hasActivity, "hasRO": hasOverlay,
        "numOfReceivers": numReceivers, "numOfServices": numServices, "numOfProviders": numProviders,
        "createdPermissions": createdPermissions, "usedPermissions": usedPermissions,
        "bootCompleted": bootCompleted, "persistent": persistent, "hasApplication": isApp, "supplier": supplier,
        "usedPermissionsList": usedPermissionsList, "createdPermissionsList": createdPermissionsList,
        "servicesList": servicesList, "receiversList": receiversList, "provdersList": provdersList).save
    end
  end

  def index
    @apps = @apps = App.where(project: "aosp")
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

end
