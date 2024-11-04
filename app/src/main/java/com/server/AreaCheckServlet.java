package com.server;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AreaCheckServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext context = getServletContext();

        try {
            float x = Float.parseFloat(req.getParameter("x"));
            float y = Float.parseFloat(req.getParameter("y"));
            int r = Integer.parseInt(req.getParameter("r"));

            if (Validator.validateX(x) && Validator.validateY(y) && Validator.validateR(r)) {
                Row row = new Row(x, y, r, Checker.hit(x, y, r));

                Object rowsData = context.getAttribute("rows");
                ArrayList<Row> rows = new ArrayList<>();
                if (rowsData != null) {
                    rows.addAll((ArrayList<Row>) context.getAttribute("rows"));
                }

                rows.add(row);

                context.setAttribute("rows", rows);
                req.setAttribute("new_row", row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("results.jsp").forward(req, resp);
    }

    private static class Validator {
        public static boolean validateX(float x) {
            return (-2.0f <= x && x <= 2.0f);
        }

        public static boolean validateY(float y) {
            return -5 <= y && y <= 3;
        }

        public static boolean validateR(int r) {
            return 1 <= r && r <= 5;
        }
    }

    private static class Checker {
        public static boolean hit(float x, float y, int r) {
            return inRect(x, y, r) || inTriangle(x, y, r) || inCircle(x, y, r);
        }

        private static boolean inRect(float x, float y, int r) {
            return (-r <= x && x <= 0) && (0 <= y && y <= r);
        }

        private static boolean inTriangle(float x, float y, int r) {
            return (0 <= x && x <= r) && (0 <= y && y <= 0.5 * r) && (y + 0.5 * (x - r) <= 0);
        }

        private static boolean inCircle(float x, float y, int r) {
            return (-0.5 * r <= x && x <= 0) && (-0.5 * r <= y && y <= 0) && ((Math.pow(x, 2) + Math.pow(y, 2) - Math.pow(0.5 * r, 2)) <= 0);
        }
    }

}