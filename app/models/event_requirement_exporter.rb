# convenience class for dumping out all submissions for a given
# EventRequirement in a different formats (PDF, zip, etc).
# This is used by the EventSubmissionsController and also by
# magic links

require 'zip'

class EventRequirementExporter
  def initialize(event_requirement)
    @event_requirement = event_requirement
    @event             = @event_requirement.event
    @submissions       = @event_requirement.event_submissions
    @unit              = @event_requirement.event.unit
  end

  #
  # given an EventRequirement, export all submissions as a single PDF
  #
  def export_pdf
    pdf_combiner = CombinePDF.new

    @submissions.each do |submission|
      if submission.attachment.attached?
        pdf_combiner << CombinePDF.parse(submission.attachment.download)
      end
    end

    # send_data pdf_combiner.to_pdf, filename: combined_filename(:pdf), type: "application/pdf"
    yield pdf_combiner.to_pdf, combined_filename(:pdf), 'application/pdf'
  end

  #
  # given an EventRequirement, export all submissions as a single zip file
  #
  def export_zip
    temp = Tempfile.new("scoutaround-event-#{@event.id}.zip")

    Zip::OutputStream.open(temp.path) do |zip|
      @submissions.each do |submission|
        if submission.attachment.attached?
          zip.put_next_entry("#{ submission.event_registration.user.full_name }.pdf")
          binary = submission.attachment.download
          zip.print binary
        end # if
      end # each submission
    end # zip output stream

    # send_file temp.path, type: 'application/zip', filename: combined_filename(:zip)
    yield temp.path, combined_filename(:zip), 'application/zip'

    # TODO: uncomment these next two lines? Or not?
    # temp.close
    # temp.unlink
  end

  private

  def combined_filename(extension)
    [
      UnitPresenter.unit_display_name(@unit),
      @unit.city,
      "#{ @event_requirement.description.pluralize }.#{ extension.to_s }"
    ].join(' ')
  end
end
