package com.github.jasmaa.yahtzee;

import java.io.StringWriter;
import java.util.Properties;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.tools.generic.MathTool;

public class App {
    public static void main(String[] args) {
        Properties p = new Properties();
        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");

        VelocityEngine velocityEngine = new VelocityEngine();
        velocityEngine.init(p);

        Template t = velocityEngine.getTemplate("templates/index.vm");

        VelocityContext context = new VelocityContext();
        context.put("math", new MathTool());

        StringWriter writer = new StringWriter();
        t.merge(context, writer);

        System.out.println(writer.toString());
    }
}
