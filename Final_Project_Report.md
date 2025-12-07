---
output:
  pdf_document: default
  html_document: default
---
# Interrogatable AI
## Final Project Report

**Team Members:** Jiexi Xu, Jinghang Sun, Yitong Liu

---

## Final Deliverables

We delivered a complete RAG-based document Q&A system that processes 697 academic PDF documents and provides accurate, cited answers to user questions. The system is production-ready with two user interfaces and comprehensive error handling.

### Core System Components

**Document Processing Pipeline:** The system automatically discovers and processes all PDF files in the project directory. It uses pdfplumber for text extraction with PyPDF2 as a fallback for problematic files. Text is cleaned and split into 512-character chunks with 50-character overlaps to preserve context at boundaries. The system successfully processed all 697 PDF documents in the corpus.

**Vector Knowledge Base:** We built a persistent vector database using ChromaDB that stores semantic embeddings for all document chunks. The system uses the paraphrase-multilingual-MiniLM-L12-v2 model to generate 384-dimensional embeddings that capture meaning across multiple languages. The knowledge base persists between sessions, so documents only need to be processed once unless explicitly rebuilt.

**Intelligent Retrieval System:** When users ask questions, the system performs semantic similarity search to find the top 15 most relevant document segments. Results are filtered by a 0.5 similarity threshold to ensure quality. The system includes a relevance verification step that checks if retrieved documents actually answer the question before generating a response.

**Answer Generation with Citations:** The system uses GPT-3.5-turbo to synthesize comprehensive answers from retrieved document segments. Every answer includes detailed source citations showing the document filename, chunk number, and similarity score. The system refuses to answer when no relevant information is found, preventing hallucination.

### User Interfaces

**Terminal Interface:** A Rich-based command-line interface provides an interactive chat experience with colored output and formatted tables. Users can ask questions directly, view system information, rebuild the knowledge base, and manage conversation history. The interface shows a "Thinking..." indicator during processing and displays answers with source reference tables.

**Web Interface:** A Streamlit-based web application offers the same functionality through a browser interface. It includes a sidebar with system metrics, expandable source references, and conversation history. The web interface is suitable for users who prefer graphical interfaces over command-line tools.

### System Features

The system includes comprehensive error handling throughout the pipeline. Failed PDF extractions are logged and skipped without crashing the system. API errors are caught and reported clearly to users. The system logs all operations to a chatbot.log file for debugging and monitoring.

Batch processing handles large document sets efficiently. The vector database processes documents in batches of 1000 to avoid memory issues. Progress is logged at each stage so users can track knowledge base construction.

Conversation history support allows the system to maintain context across multiple questions in a session. The history is limited to the last 6 messages to balance context with token efficiency.

All system parameters are configurable through the config.py file, including chunk size, overlap, retrieval count, similarity threshold, and LLM settings. This makes it easy to tune the system for different document types or use cases.

### Tools and Models

**Pre-trained Models Used:** The system leverages the paraphrase-multilingual-MiniLM-L12-v2 sentence transformer model for generating semantic embeddings. This pre-trained model creates 384-dimensional vectors that capture meaning across multiple languages without requiring training. For answer generation, we use OpenAI's GPT-3.5-turbo model via API, which provides high-quality text synthesis without local model training.

**Custom Tools Created:** We developed seven core Python modules that integrate these models into a complete RAG system. The tools include a PDF processor with dual extraction methods, an intelligent text chunker with overlap management, a vector database manager with batch processing, an LLM client with relevance checking, and two user interfaces (terminal and web). These tools work together to transform raw PDF documents into an interactive Q&A system.

**System Integration:** The complete system is packaged as a ready-to-use application with configuration management, error handling, logging, and comprehensive documentation. Users can deploy the system immediately without additional development work.

---

## Technical Summary

### System Architecture

The system follows a modular architecture with clear separation of concerns. The RAGSystem class orchestrates all components, managing both the document processing pipeline and the query answering pipeline.

```
User Interface (Terminal/Web)
    ↓
RAG System Controller
    ↓
┌─────────────────────┬─────────────────────┐
│ Document Processing │   Query Processing  │
│                     │                     │
│ PDF Processor       │  Vector Store       │
│ Text Chunker        │  LLM Client         │
│ Vector Store        │  Relevance Checker  │
└─────────────────────┴─────────────────────┘
```

The document processing pipeline extracts text from PDFs, chunks the content, generates embeddings, and stores everything in ChromaDB. The query processing pipeline retrieves relevant chunks, verifies relevance, generates answers, and extracts citations.

**Query Processing Flow:**

```
User Question
    ↓
Semantic Embedding Generation
    ↓
Vector Similarity Search (Top-15)
    ↓
Similarity Threshold Filter (≥0.5)
    ↓
Relevance Verification
    ↓
Context Building with Citations
    ↓
LLM Answer Generation
    ↓
Source Citation Extraction
    ↓
Formatted Response with References
```

### Key Technical Components

**PDF Processor:** Handles text extraction from PDF files using pdfplumber as the primary method. Includes error handling for corrupted or unreadable files. Automatically discovers all PDF files in the specified directory.

**Text Chunker:** Splits documents into overlapping segments of 512 characters with 50-character overlaps. This preserves context at chunk boundaries and ensures related information isn't split across chunks.

**Vector Store:** Manages the ChromaDB vector database with persistent storage. Generates embeddings using sentence-transformers and performs cosine similarity search. Supports batch insertion for efficient processing of large document sets.

**LLM Client:** Interfaces with OpenAI's GPT-3.5-turbo API for answer generation. Builds context from retrieved documents with proper citation formatting. Includes relevance checking to prevent answering questions without sufficient information.

**RAG System Controller:** Orchestrates all components and provides a unified interface for knowledge base construction and query answering. Manages conversation history and system state.

### Performance Metrics

The system successfully indexes all 697 PDF documents in the corpus. Knowledge base construction takes approximately 10 to 15 minutes for the full document set, processing documents in batches to manage memory efficiently.

Query response time averages 2 to 4 seconds, including retrieval, relevance checking, and answer generation. This meets the sponsor requirement of answering in under 5 seconds.

The retrieval system finds relevant segments with similarity scores above the 0.5 threshold for most queries. The top-15 retrieval setting ensures comprehensive coverage of relevant information across multiple documents.

The system maintains high accuracy by grounding all answers in retrieved document content. Source citations are provided for every claim, enabling users to verify information. The relevance checking mechanism prevents hallucination by refusing to answer when no relevant information is found.

---

## Sponsor Value & Impact

The system delivers significant value by automating the process of searching through large academic document collections. Instead of manually reading through hundreds of PDFs, researchers and students can ask natural language questions and receive accurate, cited answers in seconds.

**Time Efficiency:** What would take hours or days of manual searching now takes seconds. Users can quickly find information across 697 documents without opening a single PDF file. This dramatically speeds up literature reviews, research verification, and knowledge discovery.

**Accuracy and Reliability:** Every answer is grounded in actual document content with source citations. Users can verify claims by checking the referenced documents and chunk numbers. The system refuses to answer when it lacks relevant information, preventing false confidence in incorrect answers.

**Scalability:** The system handles the full 697-document corpus without performance degradation. The modular architecture makes it straightforward to add more documents or scale to even larger collections. The persistent vector database means documents only need to be processed once.

**Accessibility:** Two interface options (terminal and web) accommodate different user preferences. The simple command structure makes the system usable without technical training. Clear error messages and help commands guide users through the system.

**Cost Effectiveness:** The system uses efficient embedding models and optimized retrieval to minimize API costs. Batch processing and persistent storage reduce redundant computation. The relevance checking mechanism prevents unnecessary API calls when no relevant information exists.

The system transforms a static collection of PDF documents into an interactive knowledge base that understands meaning, not just keywords. This semantic understanding enables users to find information even when documents use different terminology or phrasing than their questions.

---

## Next Steps & Recommendations

### Immediate Enhancements

**Caching System:** Implement caching for frequently asked questions to reduce API costs and improve response times. Cache both retrieval results and generated answers for common queries.

**Query History:** Add persistent query history so users can review previous questions and answers. This would help users track their research progress and avoid repeating queries.

**Export Functionality:** Allow users to export conversation history, answers, and source citations to formats like Markdown or PDF. This would help researchers document their findings and share results.

### Performance Optimizations

**Embedding Model Fine-tuning:** Consider fine-tuning the embedding model on the specific document corpus to improve retrieval accuracy for domain-specific terminology.

**Parallel Processing:** Implement parallel PDF processing and embedding generation to reduce knowledge base construction time. This would be especially valuable when adding new documents to an existing knowledge base.

**Incremental Updates:** Add support for incremental knowledge base updates so new documents can be added without rebuilding the entire database. This would make the system more practical for ongoing document collections.

### Advanced Features

**Multi-document Comparison:** Enable users to ask questions that compare information across multiple documents, such as "What are the differences between the methodologies in paper X and paper Y?"

**Document-specific Search:** Allow users to search within specific documents or subsets of documents. This would help when users know which papers are relevant but want to find specific information within them.

**Advanced Filtering:** Add filters for document metadata like publication date, author, or subject area. This would help users narrow searches to relevant subsets of the corpus.

### Deployment Considerations

**Docker Containerization:** Package the system in a Docker container for easy deployment across different environments. This would simplify setup and ensure consistent behavior.

**API Development:** Create a REST API interface so the system can be integrated into other applications or used programmatically. This would enable integration with research tools and workflows.

**Cloud Deployment:** Deploy the system to cloud infrastructure for shared access by research teams. Consider using cloud vector databases for better scalability and reliability.

**User Authentication:** Add user authentication and access controls for multi-user deployments. This would enable tracking usage and managing access to sensitive documents.

### Evaluation and Testing

**Benchmark Testing:** Evaluate the system on standard Q&A datasets to measure accuracy and compare with other RAG systems. This would provide objective performance metrics.

**User Studies:** Conduct user studies with researchers and students to gather feedback on usability and identify areas for improvement. Real user feedback would guide future development priorities.

**A/B Testing:** Test different parameter configurations (chunk size, similarity threshold, retrieval count) to optimize performance for the specific document corpus.

The system is production-ready for the current use case, but these enhancements would expand its capabilities and make it suitable for broader deployment scenarios.

---

## Appendix

### System Configuration

**Current Settings:**
- Chunk size: 512 characters
- Chunk overlap: 50 characters
- Embedding model: paraphrase-multilingual-MiniLM-L12-v2
- LLM model: gpt-3.5-turbo
- Top-K retrieval: 15 segments
- Similarity threshold: 0.5
- Max tokens: 2000
- Temperature: 0.1

### Code Statistics

**Implementation:** Approximately 1,100 lines of Python code across 7 core modules:
- `rag_system.py`: Main system controller
- `pdf_processor.py`: PDF text extraction
- `text_chunker.py`: Text segmentation
- `vector_store.py`: Vector database management
- `llm_client.py`: LLM API interface
- `chatbot.py`: Terminal interface
- `app.py`: Web interface

**Documentation:** Comprehensive README with installation and usage instructions, inline code documentation, and system test script.

### Document Corpus

**Final Corpus:** 697 PDF documents successfully indexed and searchable. All documents processed with error handling for problematic files. Vector database contains embeddings for all document chunks with persistent storage in ChromaDB.

### Installation Requirements

**Dependencies:** See requirements.txt for complete list. Key dependencies include:
- pdfplumber and PyPDF2 for PDF processing
- sentence-transformers for embeddings
- chromadb for vector storage
- openai for LLM API
- streamlit for web interface
- rich for terminal interface

**Setup:** Copy env_example.txt to .env and configure OPENAI_API_KEY. Run `python chatbot.py` for terminal interface or `streamlit run app.py` for web interface.

### Performance Evaluation

**System Performance Metrics:**

| Metric | Value | Notes |
|--------|-------|-------|
| Document Corpus Size | 697 PDFs | All documents successfully processed |
| Knowledge Base Construction Time | 10-15 minutes | For full 697-document corpus |
| Query Response Time | 2-4 seconds | Average time including all processing steps |
| Retrieval Count | Top 15 segments | Configurable via config.py |
| Similarity Threshold | 0.5 | Filters low-quality matches |
| Embedding Dimensions | 384 | From multilingual MiniLM model |
| Chunk Size | 512 characters | With 50-character overlap |
| Max Answer Length | 2000 tokens | Prevents truncated responses |
| Relevance Check Threshold | 0.4 | Minimum similarity for answer generation |

**Accuracy Metrics:**
- All answers grounded in retrieved document content
- Source citations provided for every claim
- System refuses to answer when no relevant information found (prevents hallucination)
- Relevance verification step ensures retrieved documents actually address the question

### API Interface

**RAGSystem Class Methods:**

The main system interface provides the following methods:

- `build_knowledge_base(force_rebuild=False)`: Constructs or rebuilds the vector knowledge base from PDF documents
- `ask_question(question, conversation_history=None)`: Processes a user question and returns an answer with sources
- `get_system_info()`: Returns system status including document count, configuration, and LLM status

**Response Format:**

The `ask_question` method returns a dictionary with:
- `answer`: Generated answer text with citations
- `sources`: List of source documents with filename, chunk index, similarity score, and content preview
- `success`: Boolean indicating if the operation succeeded
- `context_used`: Number of document segments used in answer generation

**Example Usage:**

```python
from rag_system import RAGSystem

rag = RAGSystem()
rag.build_knowledge_base()
response = rag.ask_question("What are the main research methodologies?")
print(response['answer'])
for source in response['sources']:
    print(f"{source['filename']}: {source['similarity']:.3f}")
```

