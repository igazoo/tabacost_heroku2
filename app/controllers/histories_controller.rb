class HistoriesController < ApplicationController
  def index
    @chart1 = History.analytics(:weekly)
    
    logger.debug(@chart1)


    array=[]
    array=current_user.histories.all.map{ |history| history.created_at.month } 
    
  
    dayArray = array.group_by(&:itself)
  
    monthList = {}
      
    dayArray.each do |k,v|
      monthList[k] = v.count
    end
    
     @chart2= monthList
      logger.debug(@chart2)
  end
  
  
  def calendar
    @histories = History.all
    logger.debug(@histories)
  end
    
 
  def new
       
    @history = History.new
  
  end
  
  def create
    require 'date'
      @history= History.new(user_id:current_user.id, tabaco_id:current_user.tabaco.id,price:current_user.tabaco.price, volume:current_user.tabaco.volume,
                            brand:current_user.tabaco.brand,started_at:Date.today,end_date:Date.today)
      @event = Event.create(title: @history.brand,description:"",start_date:@history.started_at,end_date:@history.end_date)
      
    if   @history.save
      redirect_to histories_path,success: "購入しました"
    else
      flash.now[:danger] = "購入できませんでした"
      render :new
    end
  end

  
  def destroy
    @history=History.find_by(user_id:current_user.id, tabaco_id:current_user.tabaco.id,price:current_user.tabaco.price, volume:current_user.tabaco.volume,
                            brand:current_user.tabaco.brand)
    @history.destroy
    
    redirect_to histories_path, success: '購入を取り消しました'
  end
            
  private
  
   def history_params
    params.require(:history).permit(:tabaco_id,:price,:volume,:brand)
    
    
   end
end
   
  