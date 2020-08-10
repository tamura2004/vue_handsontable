<template>
  <div>
    <div ref="chart">
    </div>
    <div ref="table">
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      message: "Hello Vue!",
      chart: null,
      hot: null,
    }
  },
  async mounted() {
    const member_id = this.$cookies.get("member_id");
    const { data: { options, rows, opts } } = await axios.get(`/api/v1/members/${member_id}/allocs`);
    this.chart = new CanvasJS.Chart(this.$refs.chart, options);
    this.chart.render();

    // this.hot = new Handsontable(this.$refs.table, opts);
    // this.hot.loadData(rows);
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

#app {
  height: 370px;
  width: 100%;
}
</style>
