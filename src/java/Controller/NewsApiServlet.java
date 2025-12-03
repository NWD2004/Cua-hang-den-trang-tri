package Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "NewsApiServlet", urlPatterns = {"/api/news"})
public class NewsApiServlet extends HttpServlet {

    private static final String NEWS_DATA_PATH = "/assets/json/news.json";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Cache-Control", "public, max-age=300");

        ServletContext context = getServletContext();

        try (InputStream inputStream = context.getResourceAsStream(NEWS_DATA_PATH)) {
            if (inputStream == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"NEWS_DATA_NOT_FOUND\"}");
                return;
            }

            String payload = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
            response.getWriter().write(payload);
        } catch (IOException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"NEWS_DATA_UNAVAILABLE\"}");
        }
    }
}

