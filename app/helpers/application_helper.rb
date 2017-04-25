module ApplicationHelper

    #Full title
    def full_title(page_title = '')
        base_title = "Home"
        if page_title.empty?
            base_title
        else
            page_title
        end
    end
end
