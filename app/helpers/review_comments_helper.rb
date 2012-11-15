module ReviewCommentsHelper

  def self.construct_comments_table(comment_array)
    return "" unless comment_array.length > 0

    comment_window_html = "<table width='100%' cellpadding='3' style='table-layout: fixed; word-wrap: break-word;'>"
    for i in 0..(comment_array.length-1) do
      comment_window_html += "<tr><td><b>Comment #{i+1}:</b><br/>" +
          comment_array[i].to_s + "</td></tr>"
    end
    comment_window_html += "</table>"
    return comment_window_html
  end

   def self.construct_bookmarks_table(bookmark_array)
     comment_window_html = "<table width='100%' cellpadding='3' style='table-layout: fixed; word-wrap: break-word;'>"
     bookmark_array.each do |bookmark|

       #onclick="if(checkMouseDown(event,id)){ createComments('<%= (i) %>','<%= (i+1) %>', '<%=@shareObj['offsetarray2'][i]%>', '<%=@current_review_file.id %>')}"
       comment_window_html += "<tr onclick=\"createComments('#{bookmark.initial_line_number}','#{bookmark.initial_line_number}', '#{bookmark.file_offset}', '#{bookmark.review_file_id}')\"><td><b>Comments for Lines #{bookmark.initial_line_number}' to '#{bookmark.last_line_number}'</b><br/>" +
           + "</td></tr>"
     end
     comment_window_html += "</table>"
     return comment_window_html

   end

end
