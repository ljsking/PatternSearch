package core;

import org.apache.lucene.analysis.SimpleAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.index.Term;

public class Main {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		
		String directory = "./index";
		//RAMDirectory directory = new RAMDirectory();
		Indexer idxr = new Indexer();
		idxr.createIndex(directory);

        IndexSearcher searcher = new IndexSearcher(directory);
        //Query query = new TermQuery(new Term("partnum", "Q36")); //Not_Analyzed field. exact search.
        QueryParser parser = new QueryParser("firstName", new SimpleAnalyzer());
        Query query = parser.parse("Judy"); //for analyzed field
        TopDocs rs = searcher.search(query, null, 10);
        System.out.println(rs.totalHits);
        Document firstHit = searcher.doc(rs.scoreDocs[0].doc);
        System.out.println(firstHit.getField("lastName").stringValue());
	}

}
