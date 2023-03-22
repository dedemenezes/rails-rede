ActiveStorage::IntegrityError (File size too large. Got 12069005. Maximum is 10485760.):
      <%= form_with url: articles_path, html: { class: 'row' } do |f| %>
          <% Tag.all.each do |tag| %>
            <div class="col-12">
              <%= f.label tag.name %>
              <%= f.check_box tag.name.downcase.to_sym %>
            </div>
          <% end %>
          <%= f.submit %>
        <% end %>


    <div class="banner__content mb-5" data-slide-n-fade='in'>
      <h1 class="home__text text-primary"><%= @observatory.name %></h1>
      <h6 class='text-primary'><%= @observatory.priority_subjects.first(2).map(&:name).join(', ') %></h6>
      <div class="d-flex align-items-center">
        <%= image_tag 'icon-pin-blue.png', class: 'me-2', width: '12px', height: '16.5px' %>
        <p class='mb-0'><%= @observatory.neighborhood %></p>
      </div>
    </div>
