# frozen_string_literal: true

module V1
  module Admin
    class CategoriesController < AdminController
      before_action :find_categories, only: %i[index]
      before_action :find_category, only: %i[show update destroy restore]

      def index; end

      def create
        service = Record::CreateWithHistoryService.new
        @category = service.create! Category, modify_params, current_user
        render 'create_update', locals: { announcement_type: :created }
      end

      def show
        @histories_pagy, @histories = pagy @category.changes_histories.includes(:modifier).created_at_desc,
                                           page: params[:histories_page], items: params[:histories_per_page]
      end

      def update
        service = Record::UpdateWithHistoryService.new
        @category = service.update! @category, modify_params, current_user
        render 'create_update', locals: { announcement_type: :updated }
      end

      def destroy
        Record::DestroyWithHistoryService.new.destroy! @category, reason_param, current_user
        render_success message: :destroyed_category_successfully,
                       code: :destroyed_successfully
      end

      def restore
        Record::RestoreWithHistoryService.new.restore! @category, reason_param, current_user
        render_success message: :restored_category_successfully, code: :restored_successfully
      end

      private

      def search_params
        params.fetch(:q, {})
              .permit :parent_id_eq, :names_content_cont, :names_language_eq
      end

      def modify_params
        params.require(:category)
              .permit :parent_id, names_attributes: [:id, :language, :content]
      end

      def reason_param
        params.fetch(:category, {}).permit(changes_histories_attributes: [:content])
      end

      def find_categories
        query = Category.ransack search_params
        @pagy, @categories = pagy query.result(distinct: :id).includes(:names, :children)
                                       .main_categories.availability_desc.created_at_desc,
                                  page: params[:page], items: params[:per_page]
      end

      def find_category
        @category = Category.find params[:id]
      end
    end
  end
end
