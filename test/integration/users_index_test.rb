require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user      = users(:juank)
    @admin     = users(:juank)
    @non_admin = users(:archer)
  end

  test "index como admin solo muestra perfiles de usuarios activados" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    # Así es como funciona: abre la primera página de Usuarios, y si el usuario está activado,
    # busca un enlace para el usuario y un botón de eliminación.
    # Si el usuario no está activado, verifica que no se muestre.
    User.paginate(page: 1).each do |user|
      if user.activated?
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      else
        assert_select 'a[href=?]', user_path(user), text: user.name, count: 0
      end
    end
  end



  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      if user.activated? ## Se agrego, cuando hay usuario no activo se cae el test
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      if user.activated? ## Se agrego, cuando hay usuario no activo se cae el test
        assert_select 'a[href=?]', user_path(user), text: user.name
      end
    end
  end

end
