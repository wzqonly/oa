package com.oa.domain;

/**
 * Created by zonly on 2019/2/7.
 */
public class ModelBean {

    private String key;
    private String name;
    private String description;
    private String svgXml;
    private String jsonXml;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSvgXml() {
        return svgXml;
    }

    public void setSvgXml(String svgXml) {
        this.svgXml = svgXml;
    }

    public String getJsonXml() {
        return jsonXml;
    }

    public void setJsonXml(String jsonXml) {
        this.jsonXml = jsonXml;
    }
}
