# frozen_string_literal: true

module V1
  module Admin
    class ProductsController < AdminController
      before_action :find_products, only: %i[index]
      before_action :find_product, only: %i[show update destroy restore]

      def index; end

      def create
        service = Record::CreateWithHistoryService.new
        @product = service.create! Product, modify_params, current_user
        render 'create_update', locals: { announcement_type: :created }
      end

      def show
        @histories_pagy, @histories = pagy @product.changes_histories.includes(:modifier).created_at_desc,
                                           page: params[:histories_page], items: params[:histories_per_page]
      end

      def update
        service = Record::UpdateWithHistoryService.new
        @product = service.update! @product, modify_params, current_user
        render 'create_update', locals: { announcement_type: :updated }
      end

      def destroy
        Record::DestroyWithHistoryService.new.destroy! @product, reason_param, current_user
        render_success message: :destroyed_product_successfully, code: :destroyed_successfully
      end

      def restore
        Record::RestoreWithHistoryService.new.restore! @product, reason_param, current_user
        render_success message: :restored_product_successfully, code: :restored_successfully
      end

      private

      def search_params
        params.fetch(:q, {})
              .permit :code_cont, :availability_eq,
                      :names_content_cont, :names_language_eq
      end

      def modify_params
        params.require(:product)
              .permit :code, :sync_code, names_attributes: [:id, :language, :content]
      end

      def reason_param
        params.fetch(:product, {}).permit(changes_histories_attributes: [:content])
      end

      def find_products
        query = Product.ransack search_params
        @pagy, @products = pagy query.result(distinct: :id).includes(:names)
                                     .availability_desc.created_at_desc,
                                page: params[:page], items: params[:per_page]
      end

      def find_product
        @product = Product.find params[:id]
      end
    end
  end
end
