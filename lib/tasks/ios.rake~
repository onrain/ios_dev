namespace :go do
  task :dev => :environment do
    def set_params(e)
      par = { 
      name:"Dev # #{e}",
      manager_id:'1',
      email:"w@w.ru",
      personal_email:"q@q.ru",
      }
      par
    end
    i=0
    while(i<10) do
      res = set_params(i)
      Developer.create(res)
      i+=1
    end
    puts "creating done!"
  end
  
  task :deldev => :environment do
    Developer.destroy_all
    puts "Destroying done!"
  end



  task :manager => :environment do
    def set_params(e)
      par = { 
      name:"Manager # #{e}",
      personal_email:"q@q.ru",
      office_email:"a@qaru"
      }
      par
    end
    i=0
    while(i<20) do
      res = set_params(i)
      Manager.create(res)
      i+=1
    end
    puts "creating done!"
  end


  task :delmanager => :environment do
    Manager.destroy_all
    puts "Destroying done!"
  end
  
  
  task :package => :environment do
    @companies = {id:"1", name:"Hello amigos", website:"silver.com"}
    @clients = {id:"1", name:"test", company_id:"1", email:"s@s.com", handle:"silver/test"}
    @manager = {id:"1", name:"manager Test", personal_email:"sergey@teset.com", office_email:"test@test.com"}
    @project = {id:"1", client_id:"1", manager_id:"1", name:"lol", handle:"test/test/test"}
    @application = {id:"1", project_id:"1", product_name:"test", bundle_identifier:"test.test/test"}
    
    
    Company.create(@companies)
    Client.create(@clients)
    Manager.create(@manager)
    Project.create(@project)
    Application.create(@application)
    
    
    
    puts 'create done!'
    
  end
   
  
  
  
end
