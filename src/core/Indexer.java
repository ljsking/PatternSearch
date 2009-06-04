package core;

import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.SimpleAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.Directory;

public class Indexer {

	private List<Employee> employeeList = new ArrayList<Employee>();

	public Indexer() {
		employeeList.add(new Employee("Jane", "Doe", "123-456-8910"));
		employeeList.add(new Employee("John", "Smith", "123-456-8910"));
		employeeList.add(new Employee("Mike", "Test", "123-456-8910"));
		employeeList.add(new Employee("Judy", "Test", "123-456-8910"));
	}

	public void createIndex(String d) throws Exception {
		// Create a writer
		IndexWriter writer = new IndexWriter(d, new SimpleAnalyzer(), true,
				IndexWriter.MaxFieldLength.UNLIMITED);

		// Add documents to the index
		addDocuments(writer);

		// Lucene recommends calling optimize upon completion of indexing
		writer.optimize();
		// clean up
		writer.close();
	}

	public void addDocuments(IndexWriter writer) throws Exception {
		for (Employee e : employeeList) {
			Document doc = new Document();
			doc.add(new Field("firstName", e.getFirstName(), Field.Store.YES,
					Field.Index.ANALYZED));
			doc.add(new Field("lastName", e.getLastName(), Field.Store.YES,
					Field.Index.ANALYZED));
			doc.add(new Field("phoneNumber", e.getPhoneNumber(),
					Field.Store.YES, Field.Index.NOT_ANALYZED));

			writer.addDocument(doc);
			System.out.println(e.getFirstName());
		}
		Document doc = new Document();
		doc.add(new Field("partnum", "Q36", Field.Store.YES,
				Field.Index.NOT_ANALYZED));
		doc.add(new Field("description", "Illidium Space Modulator",
				Field.Store.YES, Field.Index.ANALYZED));
		writer.addDocument(doc);
		
		doc = new Document();
		doc.add(new Field("partnum", "Jaesung", Field.Store.YES,
				Field.Index.ANALYZED));
		doc.add(new Field("description", "010-7126-3142",
				Field.Store.YES, Field.Index.NOT_ANALYZED));
		writer.addDocument(doc);
	}

	public class Employee {
		private String firstName;
		private String lastName;
		private String phoneNumber;

		public Employee(String firstName, String lastName, String phoneNumber) {
			this.firstName = firstName;
			this.lastName = lastName;
			this.phoneNumber = phoneNumber;
		}

		public String getFirstName() {
			return firstName;
		}

		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}

		public String getLastName() {
			return lastName;
		}

		public void setLastName(String lastName) {
			this.lastName = lastName;
		}

		public String getPhoneNumber() {
			return phoneNumber;
		}

		public void setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
		}
	}
}
