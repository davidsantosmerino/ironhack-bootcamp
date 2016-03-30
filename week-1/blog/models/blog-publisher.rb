class BlogPublisher

  PAGE_SIZE = 3
  PAGINATION_ACTIONS = {
    next: -> { @current_page += 1 if !last_page? },
    prev: -> { @current_page -= 1 if !first_page? }
  }


  def initialize blog
    @posts = blog.posts
    @pages = []
    @current_page = 0
  end

  def sort_posts
    @posts.sort! { |a,b| a.date <=> b.date }
  end

  def slice_pages
    @pages = @posts.each_slice(PAGE_SIZE).to_a
  end

  def publish_front_page
    sort_posts
    slice_pages
    page
  end

  def turn_page action
    #not working
    #PAGINATION_ACTIONS[action.to_sym].try :call
    if action == "next" && !last_page?
      @current_page += 1
    elsif action == "prev" && !first_page?
      @current_page -= 1
    end

    page
  end

  def first_page?
    @current_page <= 0
  end

  def last_page?
    @current_page >= @pages.length - 1
  end

  def page_bar
    for i in 1..@pages.length
      if @current_page+1 == i
       print "#{i} ".red
      else
        print "#{i} "
      end
    end
  end

  def page
    @pages[@current_page].each do |post|
      post.print
    end
    page_bar
    page_action = gets.chomp
    turn_page page_action
  end

end
