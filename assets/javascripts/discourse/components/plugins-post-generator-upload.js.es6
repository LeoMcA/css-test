import UploadMixin from "discourse/mixins/upload";

export default Em.Component.extend(UploadMixin, {
  type: "csv",
  tagName: "span",
  uploadUrl: "/admin/plugins/post-generator/upload",

  validateUploadedFilesOptions() {
    return { csvOnly: true };
  }
});
