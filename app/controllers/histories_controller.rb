class HistoriesController < ApplicationController
  def index
    array1=[]
    #日ごとのデータを取得
    array1=current_user.histories.all.map{ |history| history.created_at.day }
    
    logger.debug(array1)
    #重複しているものを数える（同じ日のデータを配列にする）
    dayArray = array1.group_by(&:itself)
    #logger.debug(["★dayArray"=>dayArray])
    #logger.debug(["★array1"=>array1.inspect])
    #1日のデータをまとめて各日のデータを連想配列に入れる
    dayList = {}
      
    dayArray.each do |k,v|
      dayList[k] = v.count
    end
    
    @chart1= dayList
    array2=[]
    array2=current_user.histories.all.map{ |history| history.created_at.month } 
  
    dayArray = array2.group_by(&:itself)
  
    monthList = {}
      
    dayArray.each do |k,v|
      monthList[k] = v.count
    end
    
    
    histories = current_user.histories.all
    day_count = histories.first.created_at
    
    #二次元配列の初期化
    tmp = Array.new
    data = Array.new
    data.push(tmp)
    
    i = 0
    

    histories.each do |h|
      if h.created_at > day_count + 1.week
        logger.debug('---------------------１週間---------------------')
        #debugger
        day_count = day_count + 1.week
        i += 1
        data.push(Array.new)
      end
      data[i].push(h.created_at)
      logger.debug(['push'=>h.created_at])
    end
    logger.debug('---------------------------------------------')
    
    data.each_with_index do |d,i|
      logger.debug(["data[#{i}]"=>d])
    end
    logger.debug('---------------------------------------------')
    logger.debug(['data'=>data])

    
    @chart2= monthList
  end
  
  
  def index2
    histories = current_user.histories.all
    day_count = histories.first.created_at
    histories_in_a_week = Array.new
    data = Array.new
    
    histories.each do |h|
      if h.created_at < day_count + 7
        histories_in_a_week.push(h)
      else
        day_count += 7
        data.push(histories_in_a_week)
        histories_in_a_week.clear
      end
    end
    logger.debug(['★data'=>data])
  end
  
   def new
       
    @history = History.new
  
   end
  
  def create
      @history= History.new(user_id:current_user.id, tabaco_id:current_user.tabaco.id,price:current_user.tabaco.price, volume:current_user.tabaco.volume,
                            brand:current_user.tabaco.brand)
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
   
  