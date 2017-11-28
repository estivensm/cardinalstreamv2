class AccountsController < ApplicationController
  before_action :set_account, only: [ :edit, :update, :destroy]
  before_action :authenticate_user! , only: [:index, :edit, :update, :destroy]
  before_action :get_blog
 
  
  


  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

   def portal
    @account = Account.where(domain: request.subdomain).first
    @events = @account1.events.where(state: 4).order(updated_at: :desc)
   end 
  

   def iframe
   
    @event = Event.where(iframe: params[:iframe]).first
    @account = Account.find(@event.account_id)
     if @event.has_ppts 
    @array = @event.slides.split(/,/)
    @count = @array.count
    @sync =  @event.sync
    end
    views = @event.views != nil ? (@event.views + 1) : 1
    @event.update(views: views)
    @stat = Stat.new(time_stat: date, type_stat: 0, event_id: @event.id, account_id: @event.account_id , event_name: @event.name, day: date.day, month: date.month, year: date.year, hour: date.hour, minute: date.minute, second: date.second)
    @stat.save

  end  

  def live
    @nav =  request.user_agent
    a = @nav.upcase.include? "ANDROID"
    b = @nav.upcase.include? "IPHONE"
    puts a 
    puts b
       if   a  ||  b
      @navs = "SI"
    else
      @navs = "NO"
    end

    @account = Account.where(domain: request.subdomain).first
    @event = Event.where(account_id: @account.id).where(root_event: true).last
    puts @event
    puts Event.where(account_id: @account.id).where.not(state: 4).first
    puts "eventtttttttttttt"
    if @event != nil 

    @array = @event.slides.split(/,/)
    @count = @array.count
    render "live"
    else
      render "no_live" , :layout => false
    end
  end  

  def portal_show

    @nav =  request.user_agent
    a = @nav.upcase.include? "ANDROID"
    b = @nav.upcase.include? "IPHONE"
    puts a 
    puts b
       if   a  ||  b
      @navs = "SI"
    else
      @navs = "NO"
    end
   
    @event = Event.find(params[:id])
    @account = Account.find(@event.account_id)
     if @event.has_ppts && @event.slides != nil
    @array = @event.slides.split(/,/)
    @count = @array.count
    @sync =  @event.sync
    end
    @nav =  request.user_agent
    date = DateTime.now
    views = @event.views != nil ? (@event.views + 1) : 1
    @event.update(views: views)
    @stat = Stat.new(time_stat: date, type_stat: 0, event_id: @event.id, account_id: @event.account_id , event_name: @event.name, day: date.day, month: date.month, year: date.year, hour: date.hour, minute: date.minute, second: date.second)
    @stat.save
    puts "holaaaaaaaaaaaaaaaa"


  end  

  
  def portal_show_name
    
    @event = Event.where(link: params[:name]).first
    @account = Account.find(@event.account_id)
    @array = @event.slides.split(/,/)
    @count = @array.count
    @sync =  @event.sync
    render 'portal_show'
  end  


  def portal_show_video
   
    @event = Event.find(params[:id])
    @account = Account.find(@event.account_id)
    @array = @event.slides.split(/,/)
    @count = @array.count
    @sync =  @event.sync

  end  

  def real_time_stats
    
    @event = Event.find(params[:id])
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show

  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:domain, :logo, :admin_user, :user_id, :background_portal, :background_stream, :name,  :chat, :facebook, :twitter, :instagram, :linkedin)
    end
end


