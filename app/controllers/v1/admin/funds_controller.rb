# frozen_string_literal: true

module V1
  module Admin
    class FundsController < AdminController
      before_action :find_funds, only: %i[index]
      before_action :find_fund, only: %i[show update destroy restore]

      def index; end

      def create
        service = Record::CreateWithHistoryService.new
        @fund = service.create! Fund, modify_params, current_user
        render 'create_update', locals: { announcement_type: :created }
      end

      def show
        @histories_pagy, @histories = pagy @fund.changes_histories.includes(:modifier).created_at_desc,
                                           page: params[:histories_page], items: params[:histories_per_page]
      end

      def update
        service = Record::UpdateWithHistoryService.new
        @fund = service.update! @fund, modify_params, current_user
        render 'create_update', locals: { announcement_type: :updated }
      end

      def destroy
        Record::DestroyWithHistoryService.new.destroy! @fund, reason_param, current_user
        render_success message: :destroyed_fund_successfully, code: :destroyed_successfully
      end

      def restore
        Record::RestoreWithHistoryService.new.restore! @fund, reason_param, current_user
        render_success message: :restored_fund_successfully, code: :restored_successfully
      end

      private

      def search_params
        params.fetch(:q, {})
              .permit :code_cont, :availability_eq,
                      :owner_full_name_cont, :owner_email_cont
      end

      def modify_params
        params.require(:fund).permit :code, :owner_id
      end

      def reason_param
        params.fetch(:fund, {}).permit(changes_histories_attributes: [:content])
      end

      def find_funds
        query = Fund.ransack search_params
        @pagy, @funds = pagy query.result(distinct: :id).includes(:owner)
                                  .availability_desc.created_at_desc,
                             page: params[:page], items: params[:per_page]
      end

      def find_fund
        @fund = Fund.find params[:id]
      end
    end
  end
end
