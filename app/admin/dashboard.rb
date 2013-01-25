
##== Main Dashboard Page
# This ActiveAdmin is the main dashboard page
# that the appears when the admin logs in.
# 
ActiveAdmin.register_page "Dashboard" do

    #sets the priority for the label that should appear firs
    #also tells to internationalize the Label that is being displayed

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end
  
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end



    columns do        
        
        column do
            panel "Last Shipped(5)" do
                ul do
                    Order.limit(5).order("id desc").where("status = 4").map do |order|
                        li link_to("#" + order.id.to_s ,ab_admin_order_path(order)) + " ( Amount: " + order.total.to_s + "  By: " + link_to(order.user.name, ab_admin_user_path(order.user)) + ") "
                    end
                end
            end
        end

        column do
            panel "Last Unshipped(5)" do
                ul do
                    Order.limit(5).order("id desc").where("status = 2").map do |order|
                        li link_to("#" + order.id.to_s ,ab_admin_order_path(order)) + " ( Amount: " + order.total.to_s + "  By: " + link_to(order.user.name, ab_admin_user_path(order.user)) + ") "
                    end
                end
            end
        end

        column do
            panel "Last Cancelled(5)" do
                ul do
                    Order.limit(5).order("id desc").where("status = 4").map do |order|
                        li link_to("#" + order.id.to_s ,ab_admin_order_path(order)) + " ( Amount: " + order.total.to_s + "  By: " + link_to(order.user.name, ab_admin_user_path(order.user)) + ") "
                    end
                end
            end
        end

    end

    columns do

        column do
            panel "Recent Users(5)" do
                ul do
                    User.limit(5).order("id desc").map do |user|
                        li link_to(user.name,ab_admin_user_path(user))
                    end
                end
            end
        end

        column do
            panel "Recent Orders(5)" do
                ul do
                    Order.limit(5).order("id desc").map do |order|
                        li link_to("#" + order.id.to_s ,ab_admin_order_path(order)) + " ( Amount: " + order.total.to_s + "  By: " + link_to(order.user.name, ab_admin_user_path(order.user)) + ") "
                    end
                end
            end
        end

        column do
            panel "Recent Books(5)" do
                ul do
                    Book.limit(5).order("id desc").map do |book|
                        li link_to(book.name ,ab_admin_book_path(book))
                    end
                end
            end
        end

    end
    

 end
end
