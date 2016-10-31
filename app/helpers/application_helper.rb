module ApplicationHelper

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
    link_to_function(name, "add_fields(this, \"#{association}\",
      \"#{escape_javascript(fields)}\")")
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys
      function = block_given? ? update_page(&block) : args[0] || ""
      onclick = "#{"#{html_options[:onclick]};
    "if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"
    content_tag(:a, name, html_options.merge(href: href, onclick: onclick))
  end

  def display_image user, class_image = ""
    if user.avatar?
      image_tag user.avatar, class: class_image
    else
      image_tag "logo.png", class: class_image
    end
  end

  def show_status_exam exam
    case
    when exam.checked?
      t "status.danger"
    when exam.uncheck?
      t "status.info"
    when exam.testing?
      t "status.warning"
    else
      t "status.success"
    end
  end

  def status suggest
    if suggest.status?
      t "status.success"
    else
      t "status.warning"
    end
  end
end
