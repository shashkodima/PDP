public with sharing class ControllerSavePDF {
    public String renderingService { get; set; }
    public String renderedFileName { get; set; }

    public ControllerSavePDF(ApexPages.StandardController controller) {
    }

    public Boolean renderingAsHtml() {
        return ((renderingService == null) ||
                (!renderingService.startsWith('pdf')));
    }

    public String renderedContentType {
        get {
            String renderedContentType = 'text/html';

            if (!this.renderingAsHtml()) {
                renderedContentType = 'application/pdf';
            }

            return renderedContentType;
        }
    }

    public PageReference savePDF() {
        renderingService = 'pdf';

        if (this.renderedFileName != null && this.renderedFileName != '') {
            ApexPages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + this.renderedFileName + '.pdf');
        } else {
            ApexPages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + 'DefaultName.pdf');
        }

        return null;
    }
}