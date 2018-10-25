
def new
   if current_user.id == params[:user_id].to_i
     @user = current_user
     @recipe = Recipe.new(user_id: params[:user_id])
     10.times do
       quantity = @recipe.quantities.build
       quantity.build_ingredient
     end
   else
     flash[:alert] = “You are not authorized to create a recipe for another user.”
     redirect_to recipes_path
   end
 end

 <%= form_for @recipe do |form| %>
form_for [@user, @recipe] do |f|
  <div class="form-group">
    <%= form.label :name %>
    <%= form.text_field :name %>
  </div>

  <div class="form-group">
    <%= form.label :instructions %>
    <%= form.text_area :instructions %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>