package com;

import com.intuit.karate.Results;
import com.intuit.karate.Runner.Builder;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class ParallelBuilder {
    String Delimeter = ",";

    @Test
    public void executeTest() {
        Builder run = new Builder();
        run.path("classpath:com/featureFiles");
        //run.path("classpath:com/supportingFeatures");
        run.outputCucumberJson(true);
        run.tags(getTags());
        Results res = run.parallel(5);
        cucumberReportGeneration(res.getReportDir());
        Assert.assertEquals(res.getFailCount(), 0);
    }

    private List<String> getTags() {
        String tagInput = System.getProperty("tags", "");
        List<String> TagsList;
        if (tagInput.contains(Delimeter)) {
            String TagArray[] = tagInput.split(Delimeter);
            TagsList = Arrays.asList(tagInput);
            System.out.println("Given Input: " + tagInput);
            return TagsList;
        } else {
            TagsList = Arrays.asList(tagInput);
            return TagsList;
        }
    }

    private void cucumberReportGeneration(String filePath) {
        File fileDir = new File(filePath);
        Collection<File> jsonCollection = FileUtils.listFiles(fileDir, new String[]{"json"}, true);
        List<String> jsonFiles = new ArrayList<String>();
        jsonCollection.forEach(file -> jsonFiles.add(file.getAbsolutePath()));
        Configuration config = new Configuration(fileDir, "OneP Core QA");
        ReportBuilder report = new ReportBuilder(jsonFiles, config);
        report.generateReports();
    }
}
