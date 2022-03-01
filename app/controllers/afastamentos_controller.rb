class AfastamentosController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :create ]
  
  require 'csv'

  def index
  end
  
  def create
    datasrc = params[:leaves][:datasrc]
    government_body = format('%05d', params[:leaves][:government_body])
    manager_cpf = format('%011d', params[:leaves][:manager_cpf].to_i)
    reference_month = params[:leaves][:reference_month]
    lines = "9#{format('%06d', CSV.read(datasrc.path).count)}"

    datadst = "0#{government_body}" + reference_month + "000" + "\n"
    CSV.foreach(datasrc.path, headers: false) do |row|
      siape = format('%07d',row[0].to_i)
      date_leave = "#{row[1][4..7]}#{row[1][2..3]}#{row[1][0..1]}"
      id_medical_leave = format('%04d',row[2].to_i)

      datadst += "1#{manager_cpf}#{government_body}#{siape}#{date_leave}#{date_leave}#{id_medical_leave}" + "\n"
    end
    datadst += lines
    
    file_timestamp = "#{Date.current.strftime("%d%m%Y")}-#{Time.current.strftime("%H%M")}"
    send_data("#{datadst}",
      :type => 'text/plain',
      :disposition => 'attachment',
      :filename => "load_batch_covid-19-#{government_body}-#{file_timestamp}.txt")
    end
end