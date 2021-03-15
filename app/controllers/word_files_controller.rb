class WordFilesController < ApplicationController

    def index 

    end 

    def docx

    end

    def docx_post
      delete_file
      file = File.new("/#{Rails.root}/public/snippet.docx","w")
      my_html = "<html><head></head><body>"
      my_html += "<h2>#{params[:nom]}</h2>" if params[:nom]
      if params[:logo]
        file_data = params[:logo].tempfile
        file_path = File.join("public", params[:logo].original_filename)
        FileUtils.cp file_data.path, file_path
        my_html += "<p style='text-align: left;'><img src=\'http://localhost:3000/#{params[:logo].original_filename}' style=\'width: 250px; height: 100px\'></p>"
      end
      if params[:column]
        my_html += "<table style='margin-top: 30px;'><thead><tr>"
        params[:column].each do |th|
          my_html += "<td>#{th}</td>"
        end 
        my_html += "</thead><tbody>"
        params[:row].each do |k,row|
          my_html += "<tr>"
          row.each do |row_text|
            my_html +="<td>#{row_text}</td>"
          end
          my_html += "</tr>"
        end    
        my_html += "</tbody></table>"  
        my_html += "</body></html>"
      end
      # document = Htmltoword::Document.create my_html,"snippet.docx"
      file = Htmltoword::Document.create_and_save(my_html, "/#{Rails.root}/public/snippet.docx")
      File.delete(file_path) if params[:logo]
      send_file("#{Rails.root}/public/snippet.docx" ,
          :type => 'application/pdf/docx/html/htm/doc',
          :disposition => 'attachment')  
    end
    
    private

    def delete_file
      if File.exist?("#{Rails.root}/public/snippet.docx")
        File.delete("#{Rails.root}/public/snippet.docx")
      end
    end

end
