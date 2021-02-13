# frozen_string_literal: true

module V1
  module Admin
    class LegalEntitiesController < AdminController
      before_action :find_legal_entities, only: %i[index]
      before_action :find_legal_entity, only: %i[show update destroy restore]

      def index; end

      def create
        service = Record::CreateWithHistoryService.new
        @entity = service.create! LegalEntity, modify_params, current_user
        render 'create_update', locals: { announcement_type: :created }
      end

      def show
        @histories_pagy, @histories = pagy @entity.changes_histories.includes(:modifier).created_at_desc,
                                           page: params[:histories_page], items: params[:histories_per_page]
      end

      def update
        service = Record::UpdateWithHistoryService.new
        @entity = service.update! @entity, modify_params, current_user
        render 'create_update', locals: { announcement_type: :updated }
      end

      def destroy
        Record::DestroyWithHistoryService.new.destroy! @entity, reason_param, current_user
        render_success message: :destroyed_entity_successfully, code: :destroyed_successfully
      end

      def restore
        Record::RestoreWithHistoryService.new.restore! @entity, reason_param, current_user
        render_success message: :restored_entity_successfully, code: :restored_successfully
      end

      private

      def search_params
        params.fetch(:q, {})
              .permit :code_cont, :sync_code_cont, :status_eq,
                      :names_content_cont, :names_language_eq
      end

      def modify_params
        params.require(:legal_entity)
              .permit :code, :sync_code, names_attributes: [:id, :language, :content]
      end

      def reason_param
        params.fetch(:legal_entity, {}).permit(changes_histories_attributes: [:content])
      end

      def find_legal_entities
        query = LegalEntity.ransack search_params
        @pagy, @entities = pagy query.result(distinct: :id).includes(:names)
                                     .availability_desc.created_at_desc,
                                page: params[:page], items: params[:per_page]
      end

      def find_legal_entity
        @entity = LegalEntity.find params[:id]
      end
    end
  end
end
