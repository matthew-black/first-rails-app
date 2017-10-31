# AJAX in Rails

## True Life Story #1:
I was about to drown my sorrows in a pizza sandwich. Which is two Jack's frozen pizzas configured as a sandwich.
But then I found a website that gave me hope, and I said to myself, "Self, just hold off on preheating that oven. Let's give this like 30 more minutes." Anyway, [here's the thing](https://rubyplus.com/articles/4211-Using-Ajax-and-jQuery-in-Rails-5-Apps).

## yep
Install and require all the things!
```
brew install yarn
yarn add jquery
gem 'jquery-rails'
gem 'yarn'
```

## comments/_form
Things to note: 'remote: true' and the token bit. Without explicitly declaring the token, the 'protect_from_forgery' thing that lives in ApplicationController will try to bounce us. (In a typical Rails form, this token is automatically to our post request's params as a hidden field. I'm not sure why it defaults to false when 'remote: true' gets turned on.)
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
'remote: true' seems to function sort of like preventDefault when a browser has JS enabled.
```
<% if current_user %>
  <p><%= link_to "comment", new_post_comment_path(@post), remote: true %></p>
<% end %>
```

## comments/new.js.erb
Had to add this file. remote: true apparently sends Rails off to look for a relevant script to run. So 
what this does is hide the comment link and append the comment form partial into the div that's just chilling at the bottom of the page, waiting for some action.
```
$('#comment-form-link').hide();
$('#show-comment-form').append('<%= j render("form") %>');
console.log("HOLY FUCKING HELL THIS FUCKING WORKED!");
```

## comments_controller
If JS is off, this functions as usual. With JS on, Rails looks for a create.js.erb file. (Thanks, respond_to!)
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

## comments/create.js.erb
Lasly, these three lines remove the comment form that we've just submitted, bring back the comment form link, and append the new comment to a div that I placed around the list of comments.
```
$('#show-comment-form').remove();
$('#comment-form-link').show();
$('#where-the-comments-live').append('<%= j render(@comment) %>');
```

## True Life Story #2
I can't really explain any of this. I'm actually shocked that I got this working. It's 12:45, and I should be sleeping, but I just can't bear the consequence of Pat being disappointed in me yet again, so I'll add one more bit of info.
```
$('#show-comment-form').append('<%= j render("form") %>');
$('#where-the-comments-live').append('<%= j render(@comment) %>');
```
What's with the j, you might ask? 'render' is a Rails method, so JS should really have no idea what we're talking about. It turns out that it's syntactic sugar for 'escape_javascript,' so both of those lines could also be written as
```
$('#show-comment-form').append('<%= escape_javascript render("form") %>');
$('#where-the-comments-live').append('<%= escape_javascript render(@comment) %>');
```

## That's All
If you have any questions, that's a real bummer because I have none of the answers.