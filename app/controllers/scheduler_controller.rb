class SchedulerController < ApplicationController
  IDEALDATES=["1/1","1/2","1/3","1/4","1/5"]
  IDEALSTARTTIME=10.5
  IDEALENDTIME=18
  def respondToToken
    @dates=IDEALDATES
    @s_time=IDEALSTARTTIME
    @e_time=IDEALENDTIME
    @rows = (@e_time - @s_time) * 2 - 1
    @cols = @dates.length - 1
    @cellWidth = [800/(@cols+1),270].min
    @cellHeight =[800/(@rows+1),80].max
    @unselectedColor = "#DCDDDD"
    @selectedColor = "#339933"
    @name = "大江戸ハッカソン打ち上げパーティー"
    @description="hoge"
    
    @interestColor = "#586B29"
    
    # Prepare data and broadcast it via Websocket!
    r = ((IDEALENDTIME - IDEALSTARTTIME) * 2).to_i
    c = IDEALDATES.length
    d = []
    r.times do |i|
      d << (1..c).map{rand(0..10)}
    end
    #d = (1..r*c).map{rand(0..10)}
    result = JSON.generate({rows: r, cols: c, data: d})
    WebsocketRails[:newTimes].trigger 'update',  result

    render "scheduler/main"
  end

  def postNewTimes
    # process data
    
    # Prepare data and broadcast it via Websocket!
    r = ((IDEALENDTIME - IDEALSTARTTIME) * 2).to_i
    c = IDEALDATES.length
    d = []
    r.times do |i|
      d << (1..c).map{rand(0..10)}
    end
    #d = (1..r*c).map{rand(0..10)}
    result = JSON.generate({rows: r, cols: c, data: d})
    WebsocketRails[:newTimes].trigger 'update',  result
    
  end
end
