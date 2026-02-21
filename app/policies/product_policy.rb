# class ProductPolicy < ApplicationPolicy
#     class Scope < ApplicationPolicy::Scope
#       def resolve
#         if user.admin?
#           scope.all
#         elsif user.seller?
#           scope.where(user: user)
#         else
#           scope.none
#         end
#       end
#     end
#
#   def index?
#     user.seller? || user.admin?
#   end
#
#   def show?
#     user.seller? || user.admin?
#   end
#
#   def create?
#     user.seller? || user.admin?
#   end
#
#   def new?
#     create?
#   end
#
#   def update?
#     user.seller? || user.admin?
#   end
#
#   def edit?
#     update?
#   end
#
#   def destroy?
#     user.seller? || user.admin?
#   end
# end
