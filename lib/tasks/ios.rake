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
  
end
