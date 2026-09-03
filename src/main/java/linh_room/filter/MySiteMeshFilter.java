package linh_room.filter;

import java.io.IOException;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    static {
        Logger rootLogger = Logger.getLogger("");
        rootLogger.setLevel(Level.ALL);
        for (Handler h : rootLogger.getHandlers()) {
            h.setLevel(Level.ALL);
        }
        Logger.getLogger("org.sitemesh").setLevel(Level.ALL);
    }

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        System.out.println("=== MY SITEMESH FILTER APPLY CUSTOM CONFIG ===");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        System.out.println("=== SITEMESH FILTER BEFORE: " + req.getRequestURI() + " (Committed=" + res.isCommitted() + ") ===");
        try {
            super.doFilter(request, response, chain);
        } catch (Exception e) {
            System.out.println("=== SITEMESH FILTER EXCEPTION: " + e.getMessage() + " ===");
            e.printStackTrace();
            throw e;
        } finally {
            System.out.println("=== SITEMESH FILTER AFTER: " + req.getRequestURI() + " (Committed=" + res.isCommitted() + ") ===");
        }
    }
}