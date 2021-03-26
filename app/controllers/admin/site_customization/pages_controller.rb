class Admin::SiteCustomization::PagesController < Admin::SiteCustomization::BaseController
  include Translatable
  load_and_authorize_resource :page, class: "SiteCustomization::Page"

  #JHH:
  before_action :load_participants

  def load_participants
    @participants = User.all
  end
  #Fin

  def index
    @pages = SiteCustomization::Page.order("slug").page(params[:page])
  end

  def create
    if @page.save
      notice = t("admin.site_customization.pages.create.notice")
      redirect_to admin_site_customization_pages_path, notice: notice
    else
      flash.now[:error] = t("admin.site_customization.pages.create.error")
      render :new
    end
  end

  def update
    if @page.update(page_params)
      notice = t("admin.site_customization.pages.update.notice")
      redirect_to admin_site_customization_pages_path, notice: notice
    else
      flash.now[:error] = t("admin.site_customization.pages.update.error")
      render :edit
    end
  end

  def destroy
    @page.destroy!
    notice = t("admin.site_customization.pages.destroy.notice")
    redirect_to admin_site_customization_pages_path, notice: notice
  end

  private
    #JHH: Aquí se añade el campo de participantes de las páginas
    def page_params
      attributes = [:page_users_id, :slug, :more_info_flag, :print_content_flag, :status]

      params.require(:site_customization_page).permit(*attributes,
        translation_params(SiteCustomization::Page)
      )
    end

    def resource
      SiteCustomization::Page.find(params[:id])
    end
end
