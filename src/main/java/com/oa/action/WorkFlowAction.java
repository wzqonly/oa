package com.oa.action;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.oa.domain.ModelBean;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;

import javax.annotation.Resource;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zonly on 2019/2/4.
 */
@Controller("workflowAction")
@Scope("prototype")
public class WorkFlowAction extends BaseAction implements ModelDataJsonConstants {


    @Resource
    private RepositoryService repositoryService;

    @Resource
    private ObjectMapper objectMapper;

    private Map<String,Object> stencilset;

    private String modelId;

    private ObjectNode modelNode = null;

    private Model modelData;

    private Map<String,Object> map;

    private ModelBean modelBean;

    public String design(){
        return "design";
    }

    public String workflow(){
        List<Model> models = repositoryService.createModelQuery().orderByCreateTime().desc().list();
        request.setAttribute("models",models);
        return "workflow";
    }

    public String deleteModel(){
        repositoryService.deleteModel(modelId);
        return "workflow";
    }

    public String stencilset(){
        InputStream stencilsetStream = this.getClass().getClassLoader().getResourceAsStream("/activiti/stencilset_ch.json");
        try {
            String stencilsetJson = IOUtils.toString(stencilsetStream, "utf-8");
            stencilset = new Gson().fromJson(stencilsetJson, new TypeToken<Map>() {}.getType());
            return "stencilset";
        } catch (Exception e) {
            throw new ActivitiException("Error while loading stencil set", e);
        }
    }

    public String model(){
        Model model = repositoryService.getModel(modelId);
        if (model != null) {
            try {
               if (StringUtils.isNotEmpty(model.getMetaInfo())) {
                    modelNode = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
                } else {
                    modelNode = objectMapper.createObjectNode();
                    modelNode.put(MODEL_NAME, model.getName());
                }
                modelNode.put(MODEL_ID, model.getId());
                ObjectNode editorJsonNode = (ObjectNode) objectMapper.readTree(
                        new String(repositoryService.getModelEditorSource(model.getId()), "utf-8"));
                modelNode.put("model", editorJsonNode);
                //objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
                String s = objectMapper.writeValueAsString(modelNode);
                Map<String,Object> object = new Gson().fromJson(s, new TypeToken<Map>() {}.getType());

               // map = new Gson().fromJson(s);
                System.err.println();
                map = new Gson().fromJson(new Gson().toJson(object), new TypeToken<Map<String,Object>>() {}.getType());
            } catch (Exception e) {
                throw new ActivitiException("Error creating model JSON", e);
            }
        }
        return "model";

    }

    
    public String create() {

        try {

            ObjectNode modelNode = objectMapper.createObjectNode();

            modelNode.put("id", "canvas");

            modelNode.put("resourceId", "canvas");

            ObjectNode stencilSetNode = objectMapper.createObjectNode();

            stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");

            modelNode.put("stencilset", stencilSetNode);

            modelData = repositoryService.newModel();
            ObjectNode modelObjectNode = objectMapper.createObjectNode();

            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, modelBean.getName());

            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);

            String description = StringUtils.defaultString(modelBean.getDescription());

            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);

            modelData.setMetaInfo(modelObjectNode.toString());

            modelData.setName(modelBean.getName());

            modelData.setKey(StringUtils.defaultString(modelBean.getKey()));

            repositoryService.saveModel(modelData);
            repositoryService.addModelEditorSource(modelData.getId(), modelNode.toString().getBytes("utf-8"));
            return "create";
        } catch (Exception e){
            return "error";
        }
    }

    public String saveModel() {
        try {

            Model model = repositoryService.getModel(modelId);

            ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());

            modelJson.put(MODEL_NAME, modelBean.getName());
            modelJson.put(MODEL_DESCRIPTION, modelBean.getDescription());
            model.setMetaInfo(modelJson.toString());
            model.setName(modelBean.getName());

            repositoryService.saveModel(model);

            repositoryService.addModelEditorSource(model.getId(),modelBean.getJsonXml().getBytes("utf-8"));

            InputStream svgStream = new ByteArrayInputStream(modelBean.getSvgXml().getBytes("utf-8"));
            TranscoderInput input = new TranscoderInput(svgStream);

            PNGTranscoder transcoder = new PNGTranscoder();
            // Setup output
            ByteArrayOutputStream outStream = new ByteArrayOutputStream();
            TranscoderOutput output = new TranscoderOutput(outStream);

            // Do the transformation
            transcoder.transcode(input, output);
            final byte[] result = outStream.toByteArray();
            repositoryService.addModelEditorSourceExtra(model.getId(), result);
            outStream.close();
            return null;
        } catch (Exception e) {
            throw new ActivitiException("Error saving model", e);
        }
    }

    public String export(){
        try {
            Model modelData = repositoryService.getModel(modelId);
            BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
            //获取节点信息
            byte[] arg0 = repositoryService.getModelEditorSource(modelData.getId());
            JsonNode editorNode = new ObjectMapper().readTree(arg0);
            //将节点信息转换为xml
            BpmnModel bpmnModel = jsonConverter.convertToBpmnModel(editorNode);
            BpmnXMLConverter xmlConverter = new BpmnXMLConverter();
            byte[] bpmnBytes = xmlConverter.convertToXML(bpmnModel);

            ByteArrayInputStream in = new ByteArrayInputStream(bpmnBytes);
            IOUtils.copy(in, response.getOutputStream());
            String filename = modelData.getName() + ".bpmn.xml";
            response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(filename, "UTF-8"));
            response.flushBuffer();
        } catch (Exception e){
            PrintWriter out = null;
            try {
                out = response.getWriter();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            out.write("未找到对应数据");
            e.printStackTrace();
        }
        return null;
    }

    public Map<String, Object> getStencilset() {
        return stencilset;
    }

    public void setStencilset(Map<String, Object> stencilset) {
        this.stencilset = stencilset;
    }

    public ObjectNode getModelNode() {
        return modelNode;
    }

    public void setModelNode(ObjectNode modelNode) {
        this.modelNode = modelNode;
    }

    public String getModelId() {
        return modelId;
    }

    public void setModelId(String modelId) {
        this.modelId = modelId;
    }

    public Model getModelData() {
        return modelData;
    }

    public void setModelData(Model modelData) {
        this.modelData = modelData;
    }


    public ModelBean getModelBean() {
        return modelBean;
    }

    public void setModelBean(ModelBean modelBean) {
        this.modelBean = modelBean;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }
}
