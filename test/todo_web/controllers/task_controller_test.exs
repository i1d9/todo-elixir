defmodule Todo.TaskControllerTest do
    use TodoWeb.ConnCase

    test "requires user auth on all actions", %{conn: conn} do
        Enum.each([
            get(conn, Routes.task_path(conn, :new)),
            get(conn, Routes.task_path(conn, :index)),
            get(conn, Routes.task_path(conn, :show, "123")),
            get(conn, Routes.task_path(conn, :edit, "123")),
            put(conn, Routes.task_path(conn, :update, "123")),
            post(conn, Routes.task_path(conn, :create, %{})),
            delete(conn, Routes.task_path(conn, :delete, "123"))
   
            ], fn conn -> 
            assert html_response(conn, 302)
            assert conn.halted
            
        end)
    end
end