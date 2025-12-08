# Interrogatable AI
## Presentation Script

**Team Members:** Jiexi Xu, Jinghang Sun, Yitong Liu

---

## Project Summary (30 seconds)

**Problem Statement:**
Researchers and students struggle to search through large collections of academic PDFs because traditional keyword search misses relevant information that uses different terminology.

**Solution Description:**
We built Interrogatable AI, a RAG-based Q&A system that processes 697 academic PDFs and uses semantic search to provide accurate, cited answers to natural language questions in seconds.

---

## Final Deliverables (2 minutes)

We delivered a complete, production-ready system that transforms your PDF collection into an interactive knowledge base.

**What We Built:**

First, we created a document processing pipeline that automatically discovers and processes all PDF files. The system extracts text using pdfplumber, splits documents into 512-character chunks with 50-character overlaps to preserve context, and handles errors gracefully.

Second, we built a persistent vector knowledge base using ChromaDB. The system generates semantic embeddings using the multilingual MiniLM model, creating 384-dimensional vectors that understand meaning across languages. The knowledge base persists between sessions, so documents only need to be processed once.

Third, we implemented an intelligent retrieval system. When users ask questions, the system performs semantic similarity search to find the top 15 most relevant segments, filters by a 0.5 similarity threshold, and includes relevance verification before generating answers.

Fourth, we developed answer generation with automatic citations. Every answer includes source citations showing the document filename, chunk number, and similarity score. The system refuses to answer when no relevant information is found, preventing hallucination.

**User Interfaces:**

We built two interfaces. The terminal interface uses Rich for a colorful, interactive chat experience with formatted tables. The web interface uses Streamlit and provides the same functionality through a browser with expandable source references and conversation history.

**System Features:**

The system includes comprehensive error handling, batch processing for large document sets, conversation history support, and fully configurable parameters. All operations are logged for debugging and monitoring.

**Demo Recommendation:**
[Show a quick demo: Ask a question in the terminal interface, show the answer with citations, then switch to the web interface to show the same functionality]

---

## Technical Highlights (2-2.5 minutes)

**System Architecture:**

The system follows a modular architecture with clear separation of concerns. The RAGSystem controller orchestrates two main pipelines: document processing and query answering. The document processing pipeline extracts text, chunks content, generates embeddings, and stores everything in ChromaDB. The query processing pipeline retrieves relevant chunks, verifies relevance, generates answers, and extracts citations.

**Key Technical Components:**

We developed seven core Python modules totaling approximately 1,100 lines of code. The PDF processor handles text extraction with dual methods for reliability. The text chunker splits documents intelligently with overlap management. The vector store manages ChromaDB with batch processing for efficiency. The LLM client interfaces with GPT-3.5-turbo and includes relevance checking. The RAG system controller orchestrates all components.

**Query Processing Flow:**

When a user asks a question, the system generates a semantic embedding, performs vector similarity search for the top 15 segments, filters by the 0.5 similarity threshold, verifies relevance, builds context with citations, generates the answer using GPT-3.5-turbo, and extracts source citations for the final response.

**Performance Results:**

The system successfully indexes all 697 PDF documents. Knowledge base construction takes 10 to 15 minutes for the full corpus, processing documents in batches of 1000 to manage memory efficiently.

Query response time averages 2 to 4 seconds, which meets your requirement of answering in under 5 seconds. This includes retrieval, relevance checking, and answer generation.

The retrieval system finds relevant segments above the 0.5 threshold for most queries. The top-15 retrieval setting ensures comprehensive coverage across multiple documents.

**Accuracy Metrics:**

All answers are grounded in retrieved document content. Source citations are provided for every claim, enabling verification. The system refuses to answer when no relevant information is found, preventing hallucination. The relevance verification step ensures retrieved documents actually address the question.

**Integrations Completed:**

The system integrates pdfplumber and PyPDF2 for PDF processing, sentence-transformers for embeddings, ChromaDB for vector storage, OpenAI API for answer generation, Rich for the terminal interface, and Streamlit for the web interface. All components work together seamlessly.

---

## Value Delivered to Sponsor (2 minutes)

**Time Efficiency:**

What would take hours or days of manual searching now takes seconds. Users can quickly find information across all 697 documents without opening a single PDF file. This dramatically speeds up literature reviews, research verification, and knowledge discovery.

**Accuracy and Reliability:**

Every answer is grounded in actual document content with source citations. Users can verify claims by checking the referenced documents and chunk numbers. The system refuses to answer when it lacks relevant information, preventing false confidence in incorrect answers. This addresses your emphasis on reliability above all else.

**Scalability:**

The system handles the full 697-document corpus without performance degradation. The modular architecture makes it straightforward to add more documents or scale to even larger collections. The persistent vector database means documents only need to be processed once, saving time and resources.

**Accessibility:**

Two interface options accommodate different user preferences. The simple command structure makes the system usable without technical training. Clear error messages and help commands guide users through the system.

**Cost Effectiveness:**

The system uses efficient embedding models and optimized retrieval to minimize API costs. Batch processing and persistent storage reduce redundant computation. The relevance checking mechanism prevents unnecessary API calls when no relevant information exists.

**Business Value:**

The system transforms a static collection of PDF documents into an interactive knowledge base that understands meaning, not just keywords. This semantic understanding enables users to find information even when documents use different terminology or phrasing than their questions. The system is production-ready and can be deployed immediately.

---

## What's Next for the Sponsor (1.5 minutes)

**Recommended Next Steps:**

For immediate enhancements, we recommend implementing a caching system for frequently asked questions to reduce API costs and improve response times. Adding persistent query history would help users track their research progress. Export functionality would allow users to save conversation history and citations.

For performance optimizations, consider fine-tuning the embedding model on your specific document corpus to improve retrieval accuracy for domain-specific terminology. Parallel processing would reduce knowledge base construction time. Incremental updates would allow adding new documents without rebuilding the entire database.

For advanced features, multi-document comparison would enable questions like "What are the differences between methodologies in paper X and paper Y?" Document-specific search would help when users know which papers are relevant. Advanced filtering by metadata like publication date or author would narrow searches effectively.

**Limitations:**

The current system requires an OpenAI API key for answer generation. Knowledge base construction takes 10 to 15 minutes for the full corpus, though this only needs to happen once. The system works best with text-based PDFs and may have issues with scanned documents or complex layouts.

**Handoff Items:**

We're delivering the complete source code with comprehensive documentation, including a README with installation and usage instructions. The system is fully configured and ready to use. All 697 documents are successfully indexed in the vector database. We're also providing the final project report with technical details and the API interface documentation for programmatic use.

The system is production-ready for your current use case. All code is modular and well-documented, making it easy to extend and customize for your specific needs.

---

## Closing (15 seconds)

Thank you for the opportunity to work on this project. We're excited to see how Interrogatable AI helps researchers and students work more efficiently with your document collection. We're happy to answer any questions you might have.

