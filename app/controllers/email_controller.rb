class EmailController < ApplicationController

  def sendmail
#    emailStatList = EmailStat.find(:all,:conditions=>["(DATE(lastsent) < ? or lastsent IS NULL) and counter > 0", 1.from_now.to_date - 1])
   @successEmailList =[]
    params[:arr].each do |p|
       map = p[1]
       if map[:email].eql?(map[:oldemail])
         postid=map[:postid]
         post = Post.find(postid)
         puts post.locations.first
         post.locations[0].email=map[:email]
         post.locations[0].save
       end  
       if map[:email] != ''
         emailstat = EmailStat.where(:postId=>map[:postid]).first
         SupportEmailer.sendmail(post,post.locations[0],User.find(post.user_id)).deliver
          emailstat[:counter] = emailstat.counter-1
          emailstat[:lastsent] = Time.now()
          emailstat.save
          @successEmailList.push(post.locations[0].email)
       end   
       end
   
#    unless emailStatList.nil?
#      emailStatList.each do |email|
#        unless post.locations[0].email.nil? 
#          puts "sending email "
#          puts post.locations[0].email
#          SupportEmailer.sendmail(post,post.locations[0],User.find(post.user_id)).deliver
#          email[:counter] = email.counter-1
#          email[:lastsent] = Time.now()
#          email.save
#          @successEmailList.push(post.locations[0].email)
#        end
#       end
#      end
#    end
    @email_stats = EmailStat.where("counter > 0")
    render "email/index"    
    
  end
  
  def configmail
   @postId=session[:postid]
   user = User.find(session[:user][:id])
   @count = user.email_count
   @postType= Post.find(@postId).posttype
  end
  
  def saveconfig
      emailstat = EmailStat.new
      emailstat[:postId] = params[:postId]
      emailstat[:counter] = params[:counter]
      emailstat[:call] = params[:call]
      emailstat.save
      redirect_to '/users/dashboard'
  end
  
  def viewmail
    @email_stats = EmailStat.where("counter > 0")
    render "email/index"
  end
end
