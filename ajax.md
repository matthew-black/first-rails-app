# AJAX in Rails

## True Life Story #1:
I was about to drown my sorrows in a pizza sandwich. Which is two Jack's frozen pizzas configured as a sandwich.
But then I found this:
[The thing that saved Matt's stomach](https://rubyplus.com/articles/4211-Using-Ajax-and-jQuery-in-Rails-5-Apps) 

## yep
Install and require all the things!
```
brew install yarn
yarn add jquery
gem 'jquery-rails'
gem 'yarn'
```

## comments/_form
Things to note: 'remote: true' and the token thing. Without the token option, graceful degradation ain't happening.
```
<%= form_for([@post, @post.comments.build], remote: true, :authenticity_token => true) do |f| %>
  <h3>Write your comment:</h3>
  <p>
    <%= f.text_area :comment_text, :cols => 40, :rows => 5 %>
  </p>
  <p>
    <%= f.submit("Post Comment") %>
  </p>

<% end %>
```

## posts/show
```
<% if current_user %>
  <p><%= link_to "comment", new_post_comment_path(@post), remote: true %></p>
<% end %>
```

## comments_controller
```
def create
  authorize
  @post = Post.find(params[:post_id])
  @comment = @post.comments.create(comment_params)
  @comment.user_id = current_user.id
  if @comment.save
    respond_to do |f|
      f.html { redirect_to @post }
      f.js
    end
  else
    redirect_to '/'
  end
end
```

## comments/new.js.erb (additional file)
```
$('#comment-form-link').hide();
$('#show-comment-form').append('<%= j render("form") %>');
console.log("HOLY FUCKING HELL THIS FUCKING WORKED!")
```
