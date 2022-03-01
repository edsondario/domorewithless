class AfastamentosController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :create ]
  
  require 'csv'

  def index
  end
  
  def create
    id_orgao = format('%05d', params[:afastamentos][:id_orgao])
    datasrc = params[:afastamentos][:datasrc]
    lines = format('%06d', CSV.read(datasrc.path).count)

    datadst = "0#{id_orgao}" + "\n"
    CSV.foreach(datasrc.path, headers: false) do |row|
      datadst += "#{id_orgao}#{format('%07d',row[0].to_i)}#{row[1]}#{format('%04d',row[2].to_i)}" + "\n"
    end
    datadst += "9#{lines}"
    send_data("#{datadst}", :type => 'text/plain', :disposition => 'attachment', :filename => "carga_batch_afastamentos-#{id_orgao}-.txt")
  end
end
