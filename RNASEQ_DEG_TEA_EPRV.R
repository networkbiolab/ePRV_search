############################################## Load necessary packages##################################

if (!require("BiocManager")) {
  install.packages("BiocManager")
}

if (!require("Rsubread")) {
  BiocManager::install("Rsubread")
  library(Rsubread)
}

if (!require("DESeq2")) {
  BiocManager::install("DESeq2")
  library(DESeq2)
}
if (!requireNamespace("edgeR", quietly = TRUE))
  BiocManager::install("edgeR")

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("airway")

BiocManager::install("apeglm")

library("edgeR")
library("DESeq2")
library("tidyverse")
library("airway")
library("pheatmap")
library("Rsubread")
library("ggplot2")
library("pheatmap")
library("apeglm")

# Define samples and file paths
samples <- data.frame(
sampleName = c(
  "SRR5724168", "SRR5723985", "SRR5724309", "SRR5724186", "SRR5724185", "SRR5724174", "SRR5724173", 
  "SRR5724169", "SRR5724165", "SRR5724166", "SRR5724167", "SRR5724305", "SRR5724304", "SRR5723992", 
  "SRR5723993", "SRR5724467", "SRR5724162", "SRR5724161", "SRR5724077", "SRR5724365", "SRR5724370", 
  "SRR5724371", "SRR5724308", "SRR5724150", "SRR5724149", "SRR5724148", "SRR5724147", "SRR5724446", 
  "SRR5724445", "SRR5724364", "SRR5724444", "SRR5724443", "SRR5724439", "SRR5724137", "SRR5724274", 
  "SRR5724275", "SRR5724018", "SRR5724241", "SRR5724240", "SRR5724239", "SRR5724021", "SRR5724006", 
  "SRR5724020", "SRR5724074", "SRR5724073", "SRR5724080", "SRR5724078", "SRR5724171", "SRR5724172", 
  "SRR5724323", "SRR5724306", "SRR5724307", "SRR5724079", "SRR5724184", "SRR5724369", "SRR5724362", 
  "SRR5724363", "SRR5724368", "SRR5724151", "SRR5724154", "SRR5724075", "SRR5724076", "SRR5724083", 
  "SRR5724350", "SRR5724351", "SRR5724352", "SRR5724236", "SRR5724153", "SRR5724442", "SRR5724441", 
  "SRR5724440", "SRR5724044", "SRR5724238", "SRR5724361", "SRR5724403", "SRR5724404", "SRR5724270", 
  "SRR5724272", "SRR5724273", "SRR5724152", "SRR5724237", "SRR5724190", "SRR5724260", "SRR5724191", 
  "SRR5724199", "SRR5724200", "SRR5724257", "SRR5724258", "SRR5724259", "SRR5724180", "SRR5724181", 
  "SRR5724182", "SRR5724183", "SRR5724355", "SRR5724354", "SRR5724353", "SRR5724434", "SRR5724433", 
  "SRR5724392", "SRR5724233", "SRR5724391", "SRR5724264", "SRR5724176", "SRR5724177", "SRR5724082", 
  "SRR5724234", "SRR5724235", "SRR5724065", "SRR5724291", "SRR5724290", "SRR5724156", "SRR5724393", 
  "SRR5724155", "SRR5724438", "SRR5724437", "SRR5724003", "SRR5724394", "SRR5724261", "SRR5724178", 
  "SRR5724262", "SRR5724002", "SRR5724068", "SRR5724067", "SRR5724066", "SRR5724271", "SRR5724269", 
  "SRR5724268", "SRR5724376", "SRR5724373", "SRR5724372", "SRR5724263", "SRR5724179", "SRR5724001", 
  "SRR5724070", "SRR5724316", "SRR5724175", "SRR5724266", "SRR5724265", "SRR5724113", "SRR5724112", 
  "SRR5724069", "SRR5724360", "SRR5724317", "SRR5724390", "SRR5724389", "SRR5724387", "SRR5724286", 
  "SRR5724095", "SRR5724094", "SRR5724081", "SRR5724000", "SRR5723999", "SRR5723998", "SRR5724072", 
  "SRR5724071", "SRR5724388", "SRR5724064", "SRR5724063", "SRR5724204", "SRR5724004", "SRR5723996", 
  "SRR5723997", "SRR5724005", "SRR5724109", "SRR5724205", "SRR5724114", "SRR5724096", "SRR5724288", 
  "SRR5724289", "SRR5724324", "SRR5724284", "SRR5724399", "SRR5724115", "SRR5724312", "SRR5724313", 
  "SRR5724318", "SRR5724400", "SRR5724108", "SRR5724285", "SRR5724319", "SRR5724208", "SRR5724209", 
  "SRR5724093", "SRR5724091", "SRR5724092", "SRR5724453", "SRR5724454", "SRR5724455", "SRR5724090", 
  "SRR5724429", "SRR5724356", "SRR5724432", "SRR5724345", "SRR5724456", "SRR5724357", "SRR5724097", 
  "SRR5724099", "SRR5724100", "SRR5724207", "SRR5724206", "SRR5724382", "SRR5724277", "SRR5724276", 
  "SRR5724358", "SRR5724431", "SRR5724280", "SRR5724110", "SRR5724282", "SRR5724281", "SRR5724315", 
  "SRR5724314", "SRR5724311", "SRR5724310", "SRR5724267", "SRR5724120", "SRR5724111", "SRR5724349", 
  "SRR5724283", "SRR5724121", "SRR5724344", "SRR5724343", "SRR5724342", "SRR5724341", "SRR5724128", 
  "SRR5724127", "SRR5724126", "SRR5724125", "SRR5724293", "SRR5724279", "SRR5724278", "SRR5724452", 
  "SRR5724451", "SRR5724449", "SRR5724089", "SRR5724088", "SRR5724087", "SRR5724086", "SRR5724292", 
  "SRR5724450", "SRR5724337", "SRR5724131", "SRR5724340", "SRR5724339", "SRR5724338", "SRR5724132", 
  "SRR5724130", "SRR5724129", "SRR5724029", "SRR5724028", "SRR5724026", "SRR5724448", "SRR5724027", 
  "SRR5724123", "SRR5724201", "SRR5724202", "SRR5724210", "SRR5724447", "SRR5724084", "SRR5724211", 
  "SRR5724225", "SRR5724226", "SRR5724122", "SRR5724085", "SRR5724023", "SRR5724105", "SRR5724022", 
  "SRR5724124", "SRR5724119", "SRR5724118", "SRR5724230", "SRR5724428", "SRR5724228", "SRR5724227", 
  "SRR5724297", "SRR5724296", "SRR5724295", "SRR5724294", "SRR5724024", "SRR5724229", "SRR5724025", 
  "SRR5724133", "SRR5724134", "SRR5724427", "SRR5724384", "SRR5724383", "SRR5724381", "SRR5724359", 
  "SRR5723987", "SRR5723986", "SRR5724104", "SRR5724103", "SRR5724098", "SRR5724033", "SRR5724032", 
  "SRR5724430", "SRR5724336", "SRR5724335", "SRR5724213", "SRR5724212", "SRR5724460", "SRR5724459", 
  "SRR5724346", "SRR5724217", "SRR5724216", "SRR5724463", "SRR5724214", "SRR5724223", "SRR5724224", 
  "SRR5724231", "SRR5724232", "SRR5724106", "SRR5724107", "SRR5724215", "SRR5724116", "SRR5724030", 
  "SRR5724031", "SRR5724320", "SRR5724321", "SRR5724457", "SRR5724464", "SRR5724117", "SRR5724458", 
  "SRR5724158", "SRR5724218", "SRR5724219", "SRR5724466", "SRR5724465", "SRR5724462", "SRR5724461", 
  "SRR5724164", "SRR5724163", "SRR5724157", "SRR5724062", "SRR5724220", "SRR5724060", "SRR5724061", 
  "SRR5724398", "SRR5724397", "SRR5724396", "SRR5724395", "SRR5724301", "SRR5724300", "SRR5724299", 
  "SRR5724298", "SRR5724059", "SRR5724221", "SRR5724058", "SRR5724057", "SRR5724159", "SRR5724056", 
  "SRR5724322", "SRR5724170", "SRR5724055", "SRR5724329", "SRR5724330", "SRR5724160", "SRR5724406", 
  "SRR5724405", "SRR5724402", "SRR5724401", "SRR5724426", "SRR5724425", "SRR5724303", "SRR5724302", 
  "SRR5724331", "SRR5724035", "SRR5724013", "SRR5724435", "SRR5724036", "SRR5724436", "SRR5724332", 
  "SRR5724140", "SRR5724380", "SRR5724378", "SRR5724377", "SRR5724287", "SRR5724254", "SRR5724203", 
  "SRR5724347", "SRR5724102", "SRR5724139", "SRR5724101", "SRR5724034", "SRR5724141", "SRR5724142", 
  "SRR5724047", "SRR5724416", "SRR5724374", "SRR5724375", "SRR5724053", "SRR5724054", "SRR5724415", 
  "SRR5724146", "SRR5724249", "SRR5724144", "SRR5724145", "SRR5724250", "SRR5724251", "SRR5724252", 
  "SRR5724048", "SRR5724326", "SRR5724327", "SRR5724328", "SRR5724143", "SRR5724325", "SRR5724424", 
  "SRR5723990", "SRR5723991", "SRR5724135", "SRR5724136", "SRR5724045", "SRR5724015", "SRR5724348", 
  "SRR5724334", "SRR5724192", "SRR5724256", "SRR5724379", "SRR5724385", "SRR5724386", "SRR5724038", 
  "SRR5724010", "SRR5724011", "SRR5724222", "SRR5724333", "SRR5724014", "SRR5724039", "SRR5724423", 
  "SRR5724422", "SRR5724421", "SRR5724194", "SRR5724012", "SRR5724046", "SRR5724051", "SRR5724052", 
  "SRR5724037", "SRR5724412", "SRR5724413", "SRR5724414", "SRR5724245", "SRR5724193", "SRR5724246", 
  "SRR5724248", "SRR5724411", "SRR5724247", "SRR5724187", "SRR5724255", "SRR5724253", "SRR5724138", 
  "SRR5724016", "SRR5724017", "SRR5724242", "SRR5724041", "SRR5724040", "SRR5724009", "SRR5724007", 
  "SRR5724019", "SRR5724008", "SRR5723994", "SRR5723995", "SRR5723989", "SRR5723988", "SRR5724198", 
  "SRR5724197", "SRR5724196", "SRR5724195", "SRR5724367", "SRR5724366", "SRR5724244", "SRR5724243", 
  "SRR5724188", "SRR5724410", "SRR5724408", "SRR5724407", "SRR5724050", "SRR5724049", "SRR5724043", 
  "SRR5724042", "SRR5724420", "SRR5724419", "SRR5724418", "SRR5724417", "SRR5724409", "SRR5724189"
),
  fileName = paste0("/home/jvillacreses/obj_II_dic/slyco_rnaseq_tea/output_align/", c(
    "SRR5724168Aligned.sortedByCoord.out.bam", "SRR5723985Aligned.sortedByCoord.out.bam", 
    "SRR5724309Aligned.sortedByCoord.out.bam", "SRR5724186Aligned.sortedByCoord.out.bam", 
    "SRR5724185Aligned.sortedByCoord.out.bam", "SRR5724174Aligned.sortedByCoord.out.bam", 
    "SRR5724173Aligned.sortedByCoord.out.bam", "SRR5724169Aligned.sortedByCoord.out.bam", 
    "SRR5724165Aligned.sortedByCoord.out.bam", "SRR5724166Aligned.sortedByCoord.out.bam", 
    "SRR5724167Aligned.sortedByCoord.out.bam", "SRR5724305Aligned.sortedByCoord.out.bam", 
    "SRR5724304Aligned.sortedByCoord.out.bam", "SRR5723992Aligned.sortedByCoord.out.bam", 
    "SRR5723993Aligned.sortedByCoord.out.bam", "SRR5724467Aligned.sortedByCoord.out.bam", 
    "SRR5724162Aligned.sortedByCoord.out.bam", "SRR5724161Aligned.sortedByCoord.out.bam", 
    "SRR5724077Aligned.sortedByCoord.out.bam", "SRR5724365Aligned.sortedByCoord.out.bam", 
    "SRR5724370Aligned.sortedByCoord.out.bam", "SRR5724371Aligned.sortedByCoord.out.bam", 
    "SRR5724308Aligned.sortedByCoord.out.bam", "SRR5724150Aligned.sortedByCoord.out.bam", 
    "SRR5724149Aligned.sortedByCoord.out.bam", "SRR5724148Aligned.sortedByCoord.out.bam", 
    "SRR5724147Aligned.sortedByCoord.out.bam", "SRR5724446Aligned.sortedByCoord.out.bam", 
    "SRR5724445Aligned.sortedByCoord.out.bam", "SRR5724364Aligned.sortedByCoord.out.bam", 
    "SRR5724444Aligned.sortedByCoord.out.bam", "SRR5724443Aligned.sortedByCoord.out.bam", 
    "SRR5724439Aligned.sortedByCoord.out.bam", "SRR5724137Aligned.sortedByCoord.out.bam", 
    "SRR5724274Aligned.sortedByCoord.out.bam", "SRR5724275Aligned.sortedByCoord.out.bam", 
    "SRR5724018Aligned.sortedByCoord.out.bam", "SRR5724241Aligned.sortedByCoord.out.bam", 
    "SRR5724240Aligned.sortedByCoord.out.bam", "SRR5724239Aligned.sortedByCoord.out.bam", 
    "SRR5724021Aligned.sortedByCoord.out.bam", "SRR5724006Aligned.sortedByCoord.out.bam", 
    "SRR5724020Aligned.sortedByCoord.out.bam", "SRR5724074Aligned.sortedByCoord.out.bam", 
    "SRR5724073Aligned.sortedByCoord.out.bam", "SRR5724080Aligned.sortedByCoord.out.bam", 
    "SRR5724078Aligned.sortedByCoord.out.bam", "SRR5724171Aligned.sortedByCoord.out.bam", 
    "SRR5724172Aligned.sortedByCoord.out.bam", "SRR5724323Aligned.sortedByCoord.out.bam", 
    "SRR5724306Aligned.sortedByCoord.out.bam", "SRR5724307Aligned.sortedByCoord.out.bam", 
    "SRR5724079Aligned.sortedByCoord.out.bam", "SRR5724184Aligned.sortedByCoord.out.bam", 
    "SRR5724369Aligned.sortedByCoord.out.bam", "SRR5724362Aligned.sortedByCoord.out.bam", 
    "SRR5724363Aligned.sortedByCoord.out.bam", "SRR5724368Aligned.sortedByCoord.out.bam", 
    "SRR5724151Aligned.sortedByCoord.out.bam", "SRR5724154Aligned.sortedByCoord.out.bam", 
    "SRR5724075Aligned.sortedByCoord.out.bam", "SRR5724076Aligned.sortedByCoord.out.bam", 
    "SRR5724083Aligned.sortedByCoord.out.bam", "SRR5724350Aligned.sortedByCoord.out.bam", 
    "SRR5724351Aligned.sortedByCoord.out.bam", "SRR5724352Aligned.sortedByCoord.out.bam", 
    "SRR5724236Aligned.sortedByCoord.out.bam", "SRR5724153Aligned.sortedByCoord.out.bam", 
    "SRR5724442Aligned.sortedByCoord.out.bam", "SRR5724441Aligned.sortedByCoord.out.bam", 
    "SRR5724440Aligned.sortedByCoord.out.bam", "SRR5724044Aligned.sortedByCoord.out.bam", 
    "SRR5724238Aligned.sortedByCoord.out.bam", "SRR5724361Aligned.sortedByCoord.out.bam", 
    "SRR5724403Aligned.sortedByCoord.out.bam", "SRR5724404Aligned.sortedByCoord.out.bam", 
    "SRR5724270Aligned.sortedByCoord.out.bam", "SRR5724272Aligned.sortedByCoord.out.bam", 
    "SRR5724273Aligned.sortedByCoord.out.bam", "SRR5724152Aligned.sortedByCoord.out.bam", 
    "SRR5724237Aligned.sortedByCoord.out.bam", "SRR5724190Aligned.sortedByCoord.out.bam", 
    "SRR5724260Aligned.sortedByCoord.out.bam", "SRR5724191Aligned.sortedByCoord.out.bam", 
    "SRR5724199Aligned.sortedByCoord.out.bam", "SRR5724200Aligned.sortedByCoord.out.bam", 
    "SRR5724257Aligned.sortedByCoord.out.bam", "SRR5724258Aligned.sortedByCoord.out.bam", 
    "SRR5724259Aligned.sortedByCoord.out.bam", "SRR5724180Aligned.sortedByCoord.out.bam", 
    "SRR5724181Aligned.sortedByCoord.out.bam", "SRR5724182Aligned.sortedByCoord.out.bam", 
    "SRR5724183Aligned.sortedByCoord.out.bam", "SRR5724355Aligned.sortedByCoord.out.bam", 
    "SRR5724354Aligned.sortedByCoord.out.bam", "SRR5724353Aligned.sortedByCoord.out.bam", 
    "SRR5724434Aligned.sortedByCoord.out.bam", "SRR5724433Aligned.sortedByCoord.out.bam", 
    "SRR5724392Aligned.sortedByCoord.out.bam", "SRR5724233Aligned.sortedByCoord.out.bam", 
    "SRR5724391Aligned.sortedByCoord.out.bam", "SRR5724264Aligned.sortedByCoord.out.bam", 
    "SRR5724176Aligned.sortedByCoord.out.bam", "SRR5724177Aligned.sortedByCoord.out.bam", 
    "SRR5724082Aligned.sortedByCoord.out.bam", "SRR5724234Aligned.sortedByCoord.out.bam", 
    "SRR5724235Aligned.sortedByCoord.out.bam", "SRR5724065Aligned.sortedByCoord.out.bam", 
    "SRR5724291Aligned.sortedByCoord.out.bam", "SRR5724290Aligned.sortedByCoord.out.bam", 
    "SRR5724156Aligned.sortedByCoord.out.bam", "SRR5724393Aligned.sortedByCoord.out.bam", 
    "SRR5724155Aligned.sortedByCoord.out.bam", "SRR5724438Aligned.sortedByCoord.out.bam", 
    "SRR5724437Aligned.sortedByCoord.out.bam", "SRR5724003Aligned.sortedByCoord.out.bam", 
    "SRR5724394Aligned.sortedByCoord.out.bam", "SRR5724261Aligned.sortedByCoord.out.bam", 
    "SRR5724178Aligned.sortedByCoord.out.bam", "SRR5724262Aligned.sortedByCoord.out.bam", 
    "SRR5724002Aligned.sortedByCoord.out.bam", "SRR5724068Aligned.sortedByCoord.out.bam", 
    "SRR5724067Aligned.sortedByCoord.out.bam", "SRR5724066Aligned.sortedByCoord.out.bam", 
    "SRR5724271Aligned.sortedByCoord.out.bam", "SRR5724269Aligned.sortedByCoord.out.bam", 
    "SRR5724268Aligned.sortedByCoord.out.bam", "SRR5724376Aligned.sortedByCoord.out.bam", 
    "SRR5724373Aligned.sortedByCoord.out.bam", "SRR5724372Aligned.sortedByCoord.out.bam", 
    "SRR5724263Aligned.sortedByCoord.out.bam", "SRR5724179Aligned.sortedByCoord.out.bam", 
    "SRR5724001Aligned.sortedByCoord.out.bam", "SRR5724070Aligned.sortedByCoord.out.bam", 
    "SRR5724316Aligned.sortedByCoord.out.bam", "SRR5724175Aligned.sortedByCoord.out.bam", 
    "SRR5724266Aligned.sortedByCoord.out.bam", "SRR5724265Aligned.sortedByCoord.out.bam", 
    "SRR5724113Aligned.sortedByCoord.out.bam", "SRR5724112Aligned.sortedByCoord.out.bam", 
    "SRR5724069Aligned.sortedByCoord.out.bam", "SRR5724360Aligned.sortedByCoord.out.bam", 
    "SRR5724317Aligned.sortedByCoord.out.bam", "SRR5724390Aligned.sortedByCoord.out.bam", 
    "SRR5724389Aligned.sortedByCoord.out.bam", "SRR5724387Aligned.sortedByCoord.out.bam", 
    "SRR5724286Aligned.sortedByCoord.out.bam", "SRR5724095Aligned.sortedByCoord.out.bam", 
    "SRR5724094Aligned.sortedByCoord.out.bam", "SRR5724081Aligned.sortedByCoord.out.bam", 
    "SRR5724000Aligned.sortedByCoord.out.bam", "SRR5723999Aligned.sortedByCoord.out.bam", 
    "SRR5723998Aligned.sortedByCoord.out.bam", "SRR5724072Aligned.sortedByCoord.out.bam", 
    "SRR5724071Aligned.sortedByCoord.out.bam", "SRR5724388Aligned.sortedByCoord.out.bam", 
    "SRR5724064Aligned.sortedByCoord.out.bam", "SRR5724063Aligned.sortedByCoord.out.bam", 
    "SRR5724204Aligned.sortedByCoord.out.bam", "SRR5724004Aligned.sortedByCoord.out.bam", 
    "SRR5723996Aligned.sortedByCoord.out.bam", "SRR5723997Aligned.sortedByCoord.out.bam", 
    "SRR5724005Aligned.sortedByCoord.out.bam", "SRR5724109Aligned.sortedByCoord.out.bam", 
    "SRR5724205Aligned.sortedByCoord.out.bam", "SRR5724114Aligned.sortedByCoord.out.bam", 
    "SRR5724096Aligned.sortedByCoord.out.bam", "SRR5724288Aligned.sortedByCoord.out.bam", 
    "SRR5724289Aligned.sortedByCoord.out.bam", "SRR5724324Aligned.sortedByCoord.out.bam", 
    "SRR5724284Aligned.sortedByCoord.out.bam", "SRR5724399Aligned.sortedByCoord.out.bam", 
    "SRR5724115Aligned.sortedByCoord.out.bam", "SRR5724312Aligned.sortedByCoord.out.bam", 
    "SRR5724313Aligned.sortedByCoord.out.bam", "SRR5724318Aligned.sortedByCoord.out.bam", 
    "SRR5724400Aligned.sortedByCoord.out.bam", "SRR5724108Aligned.sortedByCoord.out.bam", 
    "SRR5724285Aligned.sortedByCoord.out.bam", "SRR5724319Aligned.sortedByCoord.out.bam", 
    "SRR5724208Aligned.sortedByCoord.out.bam", "SRR5724209Aligned.sortedByCoord.out.bam", 
    "SRR5724093Aligned.sortedByCoord.out.bam", "SRR5724091Aligned.sortedByCoord.out.bam", 
    "SRR5724092Aligned.sortedByCoord.out.bam", "SRR5724453Aligned.sortedByCoord.out.bam", 
    "SRR5724454Aligned.sortedByCoord.out.bam", "SRR5724455Aligned.sortedByCoord.out.bam", 
    "SRR5724090Aligned.sortedByCoord.out.bam", "SRR5724429Aligned.sortedByCoord.out.bam", 
    "SRR5724356Aligned.sortedByCoord.out.bam", "SRR5724432Aligned.sortedByCoord.out.bam", 
    "SRR5724345Aligned.sortedByCoord.out.bam", "SRR5724456Aligned.sortedByCoord.out.bam", 
    "SRR5724357Aligned.sortedByCoord.out.bam", "SRR5724097Aligned.sortedByCoord.out.bam", 
    "SRR5724099Aligned.sortedByCoord.out.bam", "SRR5724100Aligned.sortedByCoord.out.bam", 
    "SRR5724207Aligned.sortedByCoord.out.bam", "SRR5724206Aligned.sortedByCoord.out.bam", 
    "SRR5724382Aligned.sortedByCoord.out.bam", "SRR5724277Aligned.sortedByCoord.out.bam", 
    "SRR5724276Aligned.sortedByCoord.out.bam", "SRR5724358Aligned.sortedByCoord.out.bam", 
    "SRR5724431Aligned.sortedByCoord.out.bam", "SRR5724280Aligned.sortedByCoord.out.bam", 
    "SRR5724110Aligned.sortedByCoord.out.bam", "SRR5724282Aligned.sortedByCoord.out.bam", 
    "SRR5724281Aligned.sortedByCoord.out.bam", "SRR5724315Aligned.sortedByCoord.out.bam", 
    "SRR5724314Aligned.sortedByCoord.out.bam", "SRR5724311Aligned.sortedByCoord.out.bam", 
    "SRR5724310Aligned.sortedByCoord.out.bam", "SRR5724267Aligned.sortedByCoord.out.bam", 
    "SRR5724120Aligned.sortedByCoord.out.bam", "SRR5724111Aligned.sortedByCoord.out.bam", 
    "SRR5724349Aligned.sortedByCoord.out.bam", "SRR5724283Aligned.sortedByCoord.out.bam", 
    "SRR5724121Aligned.sortedByCoord.out.bam", "SRR5724344Aligned.sortedByCoord.out.bam", 
    "SRR5724343Aligned.sortedByCoord.out.bam", "SRR5724342Aligned.sortedByCoord.out.bam", 
    "SRR5724341Aligned.sortedByCoord.out.bam", "SRR5724128Aligned.sortedByCoord.out.bam", 
    "SRR5724127Aligned.sortedByCoord.out.bam", "SRR5724126Aligned.sortedByCoord.out.bam", 
    "SRR5724125Aligned.sortedByCoord.out.bam", "SRR5724293Aligned.sortedByCoord.out.bam", 
    "SRR5724279Aligned.sortedByCoord.out.bam", "SRR5724278Aligned.sortedByCoord.out.bam", 
    "SRR5724452Aligned.sortedByCoord.out.bam", "SRR5724451Aligned.sortedByCoord.out.bam", 
    "SRR5724449Aligned.sortedByCoord.out.bam", "SRR5724089Aligned.sortedByCoord.out.bam", 
    "SRR5724088Aligned.sortedByCoord.out.bam", "SRR5724087Aligned.sortedByCoord.out.bam", 
    "SRR5724086Aligned.sortedByCoord.out.bam", "SRR5724292Aligned.sortedByCoord.out.bam", 
    "SRR5724450Aligned.sortedByCoord.out.bam", "SRR5724337Aligned.sortedByCoord.out.bam", 
    "SRR5724131Aligned.sortedByCoord.out.bam", "SRR5724340Aligned.sortedByCoord.out.bam", 
    "SRR5724339Aligned.sortedByCoord.out.bam", "SRR5724338Aligned.sortedByCoord.out.bam", 
    "SRR5724132Aligned.sortedByCoord.out.bam", "SRR5724130Aligned.sortedByCoord.out.bam", 
    "SRR5724129Aligned.sortedByCoord.out.bam", "SRR5724029Aligned.sortedByCoord.out.bam", 
    "SRR5724028Aligned.sortedByCoord.out.bam", "SRR5724026Aligned.sortedByCoord.out.bam", 
    "SRR5724448Aligned.sortedByCoord.out.bam", "SRR5724027Aligned.sortedByCoord.out.bam", 
    "SRR5724123Aligned.sortedByCoord.out.bam", "SRR5724201Aligned.sortedByCoord.out.bam", 
    "SRR5724202Aligned.sortedByCoord.out.bam", "SRR5724210Aligned.sortedByCoord.out.bam", 
    "SRR5724447Aligned.sortedByCoord.out.bam", "SRR5724084Aligned.sortedByCoord.out.bam", 
    "SRR5724211Aligned.sortedByCoord.out.bam", "SRR5724225Aligned.sortedByCoord.out.bam", 
    "SRR5724226Aligned.sortedByCoord.out.bam", "SRR5724122Aligned.sortedByCoord.out.bam", 
    "SRR5724085Aligned.sortedByCoord.out.bam", "SRR5724023Aligned.sortedByCoord.out.bam", 
    "SRR5724105Aligned.sortedByCoord.out.bam", "SRR5724022Aligned.sortedByCoord.out.bam", 
    "SRR5724124Aligned.sortedByCoord.out.bam", "SRR5724119Aligned.sortedByCoord.out.bam", 
    "SRR5724118Aligned.sortedByCoord.out.bam", "SRR5724230Aligned.sortedByCoord.out.bam", 
    "SRR5724428Aligned.sortedByCoord.out.bam", "SRR5724228Aligned.sortedByCoord.out.bam", 
    "SRR5724227Aligned.sortedByCoord.out.bam", "SRR5724297Aligned.sortedByCoord.out.bam", 
    "SRR5724296Aligned.sortedByCoord.out.bam", "SRR5724295Aligned.sortedByCoord.out.bam", 
    "SRR5724294Aligned.sortedByCoord.out.bam", "SRR5724024Aligned.sortedByCoord.out.bam", 
    "SRR5724229Aligned.sortedByCoord.out.bam", "SRR5724025Aligned.sortedByCoord.out.bam", 
    "SRR5724133Aligned.sortedByCoord.out.bam", "SRR5724134Aligned.sortedByCoord.out.bam", 
    "SRR5724427Aligned.sortedByCoord.out.bam", "SRR5724384Aligned.sortedByCoord.out.bam", 
    "SRR5724383Aligned.sortedByCoord.out.bam", "SRR5724381Aligned.sortedByCoord.out.bam", 
    "SRR5724359Aligned.sortedByCoord.out.bam", "SRR5723987Aligned.sortedByCoord.out.bam", 
    "SRR5723986Aligned.sortedByCoord.out.bam", "SRR5724104Aligned.sortedByCoord.out.bam", 
    "SRR5724103Aligned.sortedByCoord.out.bam", "SRR5724098Aligned.sortedByCoord.out.bam", 
    "SRR5724033Aligned.sortedByCoord.out.bam", "SRR5724032Aligned.sortedByCoord.out.bam", 
    "SRR5724430Aligned.sortedByCoord.out.bam", "SRR5724336Aligned.sortedByCoord.out.bam", 
    "SRR5724335Aligned.sortedByCoord.out.bam", "SRR5724213Aligned.sortedByCoord.out.bam", 
    "SRR5724212Aligned.sortedByCoord.out.bam", "SRR5724460Aligned.sortedByCoord.out.bam", 
    "SRR5724459Aligned.sortedByCoord.out.bam", "SRR5724346Aligned.sortedByCoord.out.bam", 
    "SRR5724217Aligned.sortedByCoord.out.bam", "SRR5724216Aligned.sortedByCoord.out.bam", 
    "SRR5724463Aligned.sortedByCoord.out.bam", "SRR5724214Aligned.sortedByCoord.out.bam", 
    "SRR5724223Aligned.sortedByCoord.out.bam", "SRR5724224Aligned.sortedByCoord.out.bam", 
    "SRR5724231Aligned.sortedByCoord.out.bam", "SRR5724232Aligned.sortedByCoord.out.bam", 
    "SRR5724106Aligned.sortedByCoord.out.bam", "SRR5724107Aligned.sortedByCoord.out.bam", 
    "SRR5724215Aligned.sortedByCoord.out.bam", "SRR5724116Aligned.sortedByCoord.out.bam", 
    "SRR5724030Aligned.sortedByCoord.out.bam", "SRR5724031Aligned.sortedByCoord.out.bam", 
    "SRR5724320Aligned.sortedByCoord.out.bam", "SRR5724321Aligned.sortedByCoord.out.bam", 
    "SRR5724457Aligned.sortedByCoord.out.bam", "SRR5724464Aligned.sortedByCoord.out.bam", 
    "SRR5724117Aligned.sortedByCoord.out.bam", "SRR5724458Aligned.sortedByCoord.out.bam", 
    "SRR5724158Aligned.sortedByCoord.out.bam", "SRR5724218Aligned.sortedByCoord.out.bam", 
    "SRR5724219Aligned.sortedByCoord.out.bam", "SRR5724466Aligned.sortedByCoord.out.bam", 
    "SRR5724465Aligned.sortedByCoord.out.bam", "SRR5724462Aligned.sortedByCoord.out.bam", 
    "SRR5724461Aligned.sortedByCoord.out.bam", "SRR5724164Aligned.sortedByCoord.out.bam", 
    "SRR5724163Aligned.sortedByCoord.out.bam", "SRR5724157Aligned.sortedByCoord.out.bam", 
    "SRR5724062Aligned.sortedByCoord.out.bam", "SRR5724220Aligned.sortedByCoord.out.bam", 
    "SRR5724060Aligned.sortedByCoord.out.bam", "SRR5724061Aligned.sortedByCoord.out.bam", 
    "SRR5724398Aligned.sortedByCoord.out.bam", "SRR5724397Aligned.sortedByCoord.out.bam", 
    "SRR5724396Aligned.sortedByCoord.out.bam", "SRR5724395Aligned.sortedByCoord.out.bam", 
    "SRR5724301Aligned.sortedByCoord.out.bam", "SRR5724300Aligned.sortedByCoord.out.bam", 
    "SRR5724299Aligned.sortedByCoord.out.bam", "SRR5724298Aligned.sortedByCoord.out.bam", 
    "SRR5724059Aligned.sortedByCoord.out.bam", "SRR5724221Aligned.sortedByCoord.out.bam", 
    "SRR5724058Aligned.sortedByCoord.out.bam", "SRR5724057Aligned.sortedByCoord.out.bam", 
    "SRR5724159Aligned.sortedByCoord.out.bam", "SRR5724056Aligned.sortedByCoord.out.bam", 
    "SRR5724322Aligned.sortedByCoord.out.bam", "SRR5724170Aligned.sortedByCoord.out.bam", 
    "SRR5724055Aligned.sortedByCoord.out.bam", "SRR5724329Aligned.sortedByCoord.out.bam", 
    "SRR5724330Aligned.sortedByCoord.out.bam", "SRR5724160Aligned.sortedByCoord.out.bam", 
    "SRR5724406Aligned.sortedByCoord.out.bam", "SRR5724405Aligned.sortedByCoord.out.bam", 
    "SRR5724402Aligned.sortedByCoord.out.bam", "SRR5724401Aligned.sortedByCoord.out.bam", 
    "SRR5724426Aligned.sortedByCoord.out.bam", "SRR5724425Aligned.sortedByCoord.out.bam", 
    "SRR5724303Aligned.sortedByCoord.out.bam", "SRR5724302Aligned.sortedByCoord.out.bam", 
    "SRR5724331Aligned.sortedByCoord.out.bam", "SRR5724035Aligned.sortedByCoord.out.bam", 
    "SRR5724013Aligned.sortedByCoord.out.bam", "SRR5724435Aligned.sortedByCoord.out.bam", 
    "SRR5724036Aligned.sortedByCoord.out.bam", "SRR5724436Aligned.sortedByCoord.out.bam", 
    "SRR5724332Aligned.sortedByCoord.out.bam", "SRR5724140Aligned.sortedByCoord.out.bam", 
    "SRR5724380Aligned.sortedByCoord.out.bam", "SRR5724378Aligned.sortedByCoord.out.bam", 
    "SRR5724377Aligned.sortedByCoord.out.bam", "SRR5724287Aligned.sortedByCoord.out.bam", 
    "SRR5724254Aligned.sortedByCoord.out.bam", "SRR5724203Aligned.sortedByCoord.out.bam", 
    "SRR5724347Aligned.sortedByCoord.out.bam", "SRR5724102Aligned.sortedByCoord.out.bam", 
    "SRR5724139Aligned.sortedByCoord.out.bam", "SRR5724101Aligned.sortedByCoord.out.bam", 
    "SRR5724034Aligned.sortedByCoord.out.bam", "SRR5724141Aligned.sortedByCoord.out.bam", 
    "SRR5724142Aligned.sortedByCoord.out.bam", "SRR5724047Aligned.sortedByCoord.out.bam", 
    "SRR5724416Aligned.sortedByCoord.out.bam", "SRR5724374Aligned.sortedByCoord.out.bam", 
    "SRR5724375Aligned.sortedByCoord.out.bam", "SRR5724053Aligned.sortedByCoord.out.bam", 
    "SRR5724054Aligned.sortedByCoord.out.bam", "SRR5724415Aligned.sortedByCoord.out.bam", 
    "SRR5724146Aligned.sortedByCoord.out.bam", "SRR5724249Aligned.sortedByCoord.out.bam", 
    "SRR5724144Aligned.sortedByCoord.out.bam", "SRR5724145Aligned.sortedByCoord.out.bam", 
    "SRR5724250Aligned.sortedByCoord.out.bam", "SRR5724251Aligned.sortedByCoord.out.bam", 
    "SRR5724252Aligned.sortedByCoord.out.bam", "SRR5724048Aligned.sortedByCoord.out.bam", 
    "SRR5724326Aligned.sortedByCoord.out.bam", "SRR5724327Aligned.sortedByCoord.out.bam", 
    "SRR5724328Aligned.sortedByCoord.out.bam", "SRR5724143Aligned.sortedByCoord.out.bam", 
    "SRR5724325Aligned.sortedByCoord.out.bam", "SRR5724424Aligned.sortedByCoord.out.bam", 
    "SRR5723990Aligned.sortedByCoord.out.bam", "SRR5723991Aligned.sortedByCoord.out.bam", 
    "SRR5724135Aligned.sortedByCoord.out.bam", "SRR5724136Aligned.sortedByCoord.out.bam", 
    "SRR5724045Aligned.sortedByCoord.out.bam", "SRR5724015Aligned.sortedByCoord.out.bam", 
    "SRR5724348Aligned.sortedByCoord.out.bam", "SRR5724334Aligned.sortedByCoord.out.bam", 
    "SRR5724192Aligned.sortedByCoord.out.bam", "SRR5724256Aligned.sortedByCoord.out.bam", 
    "SRR5724379Aligned.sortedByCoord.out.bam", "SRR5724385Aligned.sortedByCoord.out.bam", 
    "SRR5724386Aligned.sortedByCoord.out.bam", "SRR5724038Aligned.sortedByCoord.out.bam", 
    "SRR5724010Aligned.sortedByCoord.out.bam", "SRR5724011Aligned.sortedByCoord.out.bam", 
    "SRR5724222Aligned.sortedByCoord.out.bam", "SRR5724333Aligned.sortedByCoord.out.bam", 
    "SRR5724014Aligned.sortedByCoord.out.bam", "SRR5724039Aligned.sortedByCoord.out.bam", 
    "SRR5724423Aligned.sortedByCoord.out.bam", "SRR5724422Aligned.sortedByCoord.out.bam", 
    "SRR5724421Aligned.sortedByCoord.out.bam", "SRR5724194Aligned.sortedByCoord.out.bam", 
    "SRR5724012Aligned.sortedByCoord.out.bam", "SRR5724046Aligned.sortedByCoord.out.bam", 
    "SRR5724051Aligned.sortedByCoord.out.bam", "SRR5724052Aligned.sortedByCoord.out.bam", 
    "SRR5724037Aligned.sortedByCoord.out.bam", "SRR5724412Aligned.sortedByCoord.out.bam", 
    "SRR5724413Aligned.sortedByCoord.out.bam", "SRR5724414Aligned.sortedByCoord.out.bam", 
    "SRR5724245Aligned.sortedByCoord.out.bam", "SRR5724193Aligned.sortedByCoord.out.bam", 
    "SRR5724246Aligned.sortedByCoord.out.bam", "SRR5724248Aligned.sortedByCoord.out.bam", 
    "SRR5724411Aligned.sortedByCoord.out.bam", "SRR5724247Aligned.sortedByCoord.out.bam", 
    "SRR5724187Aligned.sortedByCoord.out.bam", "SRR5724255Aligned.sortedByCoord.out.bam", 
    "SRR5724253Aligned.sortedByCoord.out.bam", "SRR5724138Aligned.sortedByCoord.out.bam", 
    "SRR5724016Aligned.sortedByCoord.out.bam", "SRR5724017Aligned.sortedByCoord.out.bam", 
    "SRR5724242Aligned.sortedByCoord.out.bam", "SRR5724041Aligned.sortedByCoord.out.bam", 
    "SRR5724040Aligned.sortedByCoord.out.bam", "SRR5724009Aligned.sortedByCoord.out.bam", 
    "SRR5724007Aligned.sortedByCoord.out.bam", "SRR5724019Aligned.sortedByCoord.out.bam", 
    "SRR5724008Aligned.sortedByCoord.out.bam", "SRR5723994Aligned.sortedByCoord.out.bam", 
    "SRR5723995Aligned.sortedByCoord.out.bam", "SRR5723989Aligned.sortedByCoord.out.bam", 
    "SRR5723988Aligned.sortedByCoord.out.bam", "SRR5724198Aligned.sortedByCoord.out.bam", 
    "SRR5724197Aligned.sortedByCoord.out.bam", "SRR5724196Aligned.sortedByCoord.out.bam", 
    "SRR5724195Aligned.sortedByCoord.out.bam", "SRR5724367Aligned.sortedByCoord.out.bam", 
    "SRR5724366Aligned.sortedByCoord.out.bam", "SRR5724244Aligned.sortedByCoord.out.bam", 
    "SRR5724243Aligned.sortedByCoord.out.bam", "SRR5724188Aligned.sortedByCoord.out.bam", 
    "SRR5724410Aligned.sortedByCoord.out.bam", "SRR5724408Aligned.sortedByCoord.out.bam", 
    "SRR5724407Aligned.sortedByCoord.out.bam", "SRR5724050Aligned.sortedByCoord.out.bam", 
    "SRR5724049Aligned.sortedByCoord.out.bam", "SRR5724043Aligned.sortedByCoord.out.bam", 
    "SRR5724042Aligned.sortedByCoord.out.bam", "SRR5724420Aligned.sortedByCoord.out.bam", 
    "SRR5724419Aligned.sortedByCoord.out.bam", "SRR5724418Aligned.sortedByCoord.out.bam", 
    "SRR5724417Aligned.sortedByCoord.out.bam", "SRR5724409Aligned.sortedByCoord.out.bam", 
    "SRR5724189Aligned.sortedByCoord.out.bam"
  )),
  condition = c(
    rep("Anthesis", 18), rep("5DPA", 36), rep("10DPA", 39), rep("20DPA", 39), rep("30DPA", 24), 
    rep("MG", 83), rep("Br", 83), rep("Pk", 83), rep("LR", 39), rep("RR", 39)
  )
)

# Define GTF file path
gtfFile <- "/home/jvillacreses/obj_II_dic/slyco_rnaseq_tea/NBL4.1_slyco_complete_eprv.gtf"

# Run featureCounts
counts <- featureCounts(files = samples$fileName,
                        annot.ext = gtfFile,
                        isPairedEnd = FALSE,
                        strandSpecific = 0,
                        nthreads = 28,
                        isGTFAnnotationFile = TRUE,
			GTF.attrType="gene_id",
			GTF.featureType="gene",
			useMetaFeatures=TRUE,
			allowMultiOverlap=TRUE,
			countMultiMappingReads=TRUE) # Indicate that the annotation file is a GTF file

# Save the counts object
save(counts, file = "featureCounts_counts_meta.RData")

# Create DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = counts$counts,
                              colData = samples,
                              design = ~ condition)
# Run DESeq
dds <- DESeq(dds)

# Save the dds object
save(dds, file = "dds_object_meta.RData")



####################################  DEG   ####################################################### Load necessary librarieslibrary(DESeq2)library(pheatmap)##### LOGFC from DESeq2 for ePRV Sequences ###### Load your DESeq2 dataset objectload("dds_object_new.RData")# Pre-filtering the countssmallestGroupSize <- 18keep <- rowSums(counts(dds) >= 10) >= smallestGroupSizedds <- dds[keep,]# Load ePRV gene IDs (choose the appropriate file)# specific_genes_ids_eprv <- read.csv("gene_ids_eprv_only.txt", header = FALSE, stringsAsFactors = FALSE)$V1specific_genes_ids_eprv <- read.csv("gene_ids_eprv_solyc.txt", header = FALSE, stringsAsFactors = FALSE)$V1# Ensure that the 'condition' column is a factor and properly setdds$condition <- factor(dds$condition, levels = c("Anthesis", "5DPA", "10DPA", "20DPA", "30DPA", "MG", "Br", "Pk", "LR", "RR"))# Run DESeq2dds <- DESeq(dds)# Define thresholdspadj_threshold <- 0.05logFC_threshold <- 1# Define the stages explicitly, skipping "Anthesis" as controlstages <- levels(dds$condition)[-1]# Initialize a list to store resultslist_of_results <- list()# Loop through each stage for DE comparisonfor (i in stages) {  # Use correct contrast definition  res <- results(dds, contrast = c("condition", i, "Anthesis"), alpha = padj_threshold)  res$padj <- p.adjust(res$pvalue, method = "BH")    # Filter significant genes  valid_indices <- !is.na(res$padj) & !is.na(res$log2FoldChange) &    res$padj < padj_threshold & abs(res$log2FoldChange) > log2(logFC_threshold)    if (any(valid_indices)) {    sig_res <- res[valid_indices, ]    sig_res$gene <- rownames(sig_res)    results_name <- paste("results_", i, sep = "")    list_of_results[[results_name]] <- sig_res        # Save significant DEGs per stage    write.csv(sig_res, paste0("DEG_", i, ".csv"), row.names = FALSE)  }}# Initialize matrix for storing log2FoldChange valueslogFC_matrix <- matrix(nrow = length(specific_genes_ids_eprv), ncol = length(stages))rownames(logFC_matrix) <- specific_genes_ids_eprvcolnames(logFC_matrix) <- stages# Store genes that are significant in at least one stagesignificant_eprv_genes <- c()# Fill the matrix with logFC values per stagefor (stage in stages) {  res <- results(dds, contrast = c("condition", stage, "Anthesis"))  res$padj <- p.adjust(res$pvalue, method = "BH")    # Identify significant ePRV genes for this stage  sig_idx <- which(    rownames(res) %in% specific_genes_ids_eprv &      !is.na(res$padj) &      res$padj < padj_threshold &      abs(res$log2FoldChange) > log2(logFC_threshold)  )    if (length(sig_idx) > 0) {    significant_eprv_genes <- union(significant_eprv_genes, rownames(res)[sig_idx])  }    # Store logFC values for all ePRV genes (even if not significant)  matched_logFC <- res[specific_genes_ids_eprv, "log2FoldChange"]  logFC_matrix[, stage] <- matched_logFC}# Replace NAs with 0logFC_matrix[is.na(logFC_matrix)] <- 0# Subset to only DEGs (ePRVs that were significant in at least one stage)logFC_matrix <- logFC_matrix[rownames(logFC_matrix) %in% significant_eprv_genes, ]# Write matrix to filewrite.table(logFC_matrix, "DEG_logFC_matrix_clean.txt", row.names = TRUE, col.names = TRUE, sep = "\t")# Optional: Save as solyc/ePRV version# write.table(logFC_matrix, "DEG_logFC_matrix_clean_eprv_solyc.txt", row.names = TRUE, col.names = TRUE, sep = "\t")# Heatmap 1: Without row namespdf("DEG_ePRV_Heatmap_new.pdf")pheatmap(logFC_matrix,         show_rownames = TRUE,         cluster_rows = TRUE,         cluster_cols = FALSE,         scale = "row",         color = colorRampPalette(c("blue", "white", "red"))(100),         fontsize_row = 2,         border_color = NA)dev.off()# Heatmap 2: With row names, no borderspdf("DEG_ePRV_Heatmap_new2_eprv_solyc.pdf")pheatmap(logFC_matrix,         show_rownames = TRUE,         cluster_rows = TRUE,         cluster_cols = FALSE,         scale = "row",         color = colorRampPalette(c("blue", "white", "red"))(100),         fontsize_row = 2,         border_color = NA)dev.off()################################################### upset plot DESEQ2 ############################################## Load necessary library for UpSet plotslibrary(UpSetR)# Define thresholds for upregulation and downregulationlogFC_threshold <- 1  # Adjust this as needed based on your specific threshold# Initialize lists to hold upregulated and downregulated gene sets for each stagesets_up <- list()sets_down <- list()# Iterate through each stage to classify genesfor (stage in colnames(logFC_matrix)) {  # Identify upregulated genes  upregulated <- rownames(logFC_matrix)[logFC_matrix[, stage] > logFC_threshold]  sets_up[[stage]] <- upregulated    # Identify downregulated genes  downregulated <- rownames(logFC_matrix)[logFC_matrix[, stage] < -logFC_threshold]  sets_down[[stage]] <- downregulated}# Ensure that lists do not contain NA valuessets_up <- lapply(sets_up, function(x) x[!is.na(x)])sets_down <- lapply(sets_down, function(x) x[!is.na(x)])# UpSet plots require named lists for proper axis labelingnames(sets_up) <- colnames(logFC_matrix)names(sets_down) <- colnames(logFC_matrix)pdf("Upregulated_ePRV_UpSetPlot_Ordered1.pdf")upset(fromList(sets_up), nsets=9, sets=c( "RR",  "LR", "Pk", "Br", "MG",  "30DPA", "20DPA", "10DPA", "5DPA"), keep.order=T, main.bar.color = "red", order.by = "freq", text.scale = 1.5)dev.off()#este es el que usare en el paper solo contiene eprvpdf("Upregulated_ePRV_UpSetPlot_Ordered2.pdf")upset(fromList(sets_up), nsets=9, sets=c( "RR",  "LR", "Pk", "Br", "MG",  "30DPA", "20DPA", "10DPA", "5DPA"), keep.order=T, main.bar.color = "red", order.by = "degree", text.scale = 1.5, line.size = 0.5)dev.off()pdf("Upregulated_ePRV_UpSetPlot_Ordered2_eprv_solyc.pdf")upset(fromList(sets_up), nsets=9, sets=c( "RR",  "LR", "Pk", "Br", "MG",  "30DPA", "20DPA", "10DPA", "5DPA"), keep.order=T, main.bar.color = "red", order.by = "degree", text.scale = 1.5, line.size = 0.5)dev.off()pdf("Downregulated_ePRV_UpSetPlot_Ordered1.pdf")upset(fromList(sets_up), nsets=9, sets=c( "RR",  "LR", "Pk", "Br", "MG",  "30DPA", "20DPA", "10DPA", "5DPA"), keep.order=T, main.bar.color = "blue", order.by = "freq", text.scale = 1.5)dev.off()#este es el que usare en el paper solo contiene eprvpdf("Downregulated_ePRV_UpSetPlot_Ordered2.pdf")upset(fromList(sets_down), nsets=9, sets=c( "RR",  "LR", "Pk", "Br", "MG",  "30DPA", "20DPA", "10DPA", "5DPA"), keep.order=T, main.bar.color = "blue", order.by = "degree", text.scale = 1.5, line.size = 0.5)dev.off()pdf("Downregulated_ePRV_UpSetPlot_Ordered2_eprv_solyc.pdf")upset(fromList(sets_down), nsets=9, sets=c( "RR",  "LR", "Pk", "Br", "MG",  "30DPA", "20DPA", "10DPA", "5DPA"), keep.order=T, main.bar.color = "blue", order.by = "degree", text.scale = 1.5, line.size = 0.5)dev.off()# Concatenate all upregulated gene sets into one data frameupregulated_df <- do.call(rbind, lapply(names(sets_up), function(stage) {  data.frame(Stage = stage, Gene = sets_up[[stage]], stringsAsFactors = FALSE)}))# Save to a text filewrite.table(upregulated_df, "upregulated_genes.txt", sep = "\t", row.names = FALSE, quote = FALSE)write.table(upregulated_df, "upregulated_genes_eprv_solyc.txt", sep = "\t", row.names = FALSE, quote = FALSE)# Concatenate all downregulated gene sets into one data framedownregulated_df <- do.call(rbind, lapply(names(sets_down), function(stage) {  data.frame(Stage = stage, Gene = sets_down[[stage]], stringsAsFactors = FALSE)}))# Save to a text filewrite.table(downregulated_df, "downregulated_genes.txt", sep = "\t", row.names = FALSE, quote = FALSE)write.table(downregulated_df, "downregulated_genes_eprv_solyc.txt", sep = "\t", row.names = FALSE, quote = FALSE)



######################################################### DEG Full Matrix selection of the significants #######################################################library(DESeq2)# Load your DESeq2 dataset object# load("dds_object_new.RData")# Pre-filtering the countssmallestGroupSize <- 18keep <- rowSums(counts(dds) >= 10) >= smallestGroupSizedds <- dds[keep,]# Ensure that 'condition' is a factor with levels in the desired orderdds$condition <- factor(dds$condition, levels = c("Anthesis", "5DPA", "10DPA", "20DPA", "30DPA", "MG", "Br", "Pk", "LR", "RR"))# Run DESeq2dds <- DESeq(dds)# ========== Filter full DEG matrix to keep only significant genes ==========# You should have 'dds' already loaded and processed at this point# Define thresholds againpadj_threshold <- 0.05logFC_threshold <- 1stages <- levels(dds$condition)[-1]# Re-run significance filtering across all genessignificant_genes_all_stages <- c()for (stage in stages) {  res <- results(dds, contrast = c("condition", stage, "Anthesis"))  res$padj <- p.adjust(res$pvalue, method = "BH")    sig_genes <- rownames(res)[which(    !is.na(res$padj) &      res$padj < padj_threshold &      abs(res$log2FoldChange) > log2(logFC_threshold)  )]    significant_genes_all_stages <- union(significant_genes_all_stages, sig_genes)}# Read the full matrix from file (in case you're starting fresh)logFC_matrix_fulldeg <- read.table("DEG_logFC_matrix_fulldeg.txt", header = TRUE, sep = "\t", check.names = FALSE)# Filter to keep only significant geneslogFC_matrix_significant_only <- logFC_matrix_fulldeg[rownames(logFC_matrix_fulldeg) %in% significant_genes_all_stages, ]# Save filtered matrixwrite.table(logFC_matrix_significant_only, "DEG_logFC_matrix_fulldeg_significant_only.txt", sep = "\t", row.names = TRUE, col.names = NA, quote = FALSE)# Optional printcat("✅ Significant genes extracted from full DEG matrix:\n")cat("   Total:", nrow(logFC_matrix_significant_only), "genes saved to DEG_logFC_matrix_fulldeg_significant_only.txt\n")